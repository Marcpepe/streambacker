Parse.Cloud.job("twitchData", function(request, status) {
  // Streamer list
  var streamers = 'imaqtpie,phantoml0rd,sodapoppin,lirik,riotgames,kolento,trumpsc';

  // Parse.Cloud.useMasterKey();
  // Classes
  var Recording = Parse.Object.extend("Recording");
  var Game = Parse.Object.extend("Game");
  var GameStamp = Parse.Object.extend("GameStamp");
  var Channel = Parse.Object.extend("Channel");
  var Stream = Parse.Object.extend("Stream");
  var StreamStamp = Parse.Object.extend("StreamStamp");
  // Instances
  var game_data;
  var recording;
  var gameStamps;

  Parse.Cloud.httpRequest({
    url: 'https://api.twitch.tv/kraken/games/top?limit=100&offset=0',
    headers: {
      'Accept': 'application/vnd.twitchtv.v3+json',
      'Content-Type': 'application/json;charset=utf-8',
      'Client-ID': 'kdhloc045kq5oabztj8yf447vw49b5a'
    }
  }).then(function(httpResponse) {
    console.log('Games http request successful : '+httpResponse.text);
    game_data = httpResponse.data["top"];
    recording = new Recording();
    gameStamps = {}

    var promises = [];
    for (var i = 0; i < game_data.length; i++) {
      (function(i) {
        // if game exists, check if maxViewerCount/maxChannelsCount (and logo, etc) need update; else create
        var game_query = new Parse.Query(Game);
        game_query.equalTo('twitchId', game_data[i].game._id);

        promises.push(
          game_query.find().then(
            function(results) {
              if (results.length > 0) {
                // console.log('Game already created');
                game = results[0];
                if (game.get('maxViewers') < game_data[i].viewers) {
                  game.set('maxViewers', game_data[i].viewers);
                  console.log('Updated maxViewers!')
                  game.set('maxViewersStamp', new Date());
                }
                if (game.get('maxChannels') < game_data[i].channels) {
                  game.set('maxChannels', game_data[i].channels);
                  console.log('Updated maxChannels!')
                  game.set('maxChannelsStamp', new Date());
                }

              } else {
                // console.log('Game needs to be created');
                game = new Game();
                game.set('name', game_data[i].game.name);
                game.set('twitchId', game_data[i].game._id);
                game.set('maxViewers', game_data[i].viewers);
                game.set('maxViewersStamp', new Date());
                game.set('maxChannels', game_data[i].channels);
                game.set('maxChannelsStamp', new Date());
                game.set('box', game_data[i].game.box.medium);
              }

              // create gamestamp and attach to game and recording
              var gameStamp = new GameStamp();
              gameStamp.set('viewers', game_data[i].viewers);
              gameStamp.set('channels', game_data[i].channels);
              gameStamp.set('game', game);
              gameStamp.set('recording', recording);
              gameStamps[game.name] = gameStamp;

              return gameStamp.save();
            },
            function(error) {
              console.error(error);
              status.error("Error...:x");
            }
          )
        );
      })(i);
    }
    return Parse.Promise.when(promises);

  }).then(function() {
    console.log("Requesting data for streamers : "+streamers);
    Parse.Cloud.httpRequest({
      url: 'https://api.twitch.tv/kraken/streams',
      params: {
        channel : streamers
      },
      headers: {
        'Accept': 'application/vnd.twitchtv.v3+json',
        'Content-Type': 'application/json;charset=utf-8',
        'Client-ID': 'kdhloc045kq5oabztj8yf447vw49b5a'
      }
    }).then(function(res) {
      var stream_data = res.data["streams"];

      var promises_streams = [];
      for (var i = 0; i < stream_data.length; i++) {
        (function(i) {
          // if channel exists, check if maxViewers (and logo, etc) need update; else create
          var channel_query = new Parse.Query(Channel);
          channel_query.equalTo('twitchId', stream_data[i].channel._id);
          promises_streams.push(
            channel_query.find().then(
              function(results) {
                if (results.length > 0) {
                  console.log('Channel already created');
                  var channel = results[0];
                  if (results[0].get('maxViewers') < stream_data[i].viewers) {
                    channel.set('maxViewers', stream_data[i].viewers);
                    console.log('maxViewersStamp updated!')
                    channel.set('maxViewersStamp', new Date());
                  }
                  if (results[0].get('views') < stream_data[i].channel.views) {
                    console.log('views updated!')
                    channel.set('views', stream_data[i].channel.views);
                  }
                  if (results[0].get('followers') < stream_data[i].channel.followers) {
                    console.log('followers updated!')
                    channel.set('followers', stream_data[i].channel.followers);
                  }
                  // TODO: add maxViewerStamp
                  // TODO: traffic = viewers / total viewers in twitch for this game
                  // var traffic = ...
                  // if (results[0].get('maxTraffic') < stream_data[i].channels) {
                    // game.set('maxChannels', stream_data[i].channels);
                  // }
                  var stream_query = new Parse.Query(Stream);
                  stream_query.equalTo('twitchId', stream_data[i]._id);
                  return stream_query.find().then(
                    function(res) {
                      if (res.length > 0) {
                        console.log('Stream already exists');
                        var stream = res[0];
                        // stream.set('uptime', new Date() - new Date(stream_data[i].created_at))
                      } else {
                        console.log('Stream did not exist')
                        var stream = new Stream();
                        stream.set('twitchId', stream_data[i]._id);
                        stream.set('creationStamp', new Date(stream_data[i].created_at));
                        // stream.set('uptime', new Date() - new Date(stream_data[i].created_at))
                        stream.set('channel', channel);
                      }
                      var streamStamp = new StreamStamp();
                      streamStamp.set('viewers', stream_data[i].viewers);
                      streamStamp.set('status', stream_data[i].channel.status);
                      streamStamp.set('game', gameStamps[stream_data[i].game]);
                      streamStamp.set('stream', stream);
                      return streamStamp.save();
                    }
                  )
                } else {
                  console.log('Channel needs to be created');
                  var channel = new Channel();
                  channel.set('name', stream_data[i].channel.name);
                  channel.set('display_name', stream_data[i].channel.display_name);
                  channel.set('twitchId', stream_data[i].channel._id);
                  channel.set('maxViewers', stream_data[i].viewers);
                  channel.set('maxViewersStamp', new Date());
                  channel.set('views', stream_data[i].channel.views);
                  channel.set('followers', stream_data[i].channel.followers);
                  // TODO: add partner, language, broadcaster_language, etc..
                  var stream = new Stream();
                  stream.set('twitchId', stream_data[i]._id);
                  stream.set('channel', channel);
                  var streamStamp = new StreamStamp();
                  streamStamp.set('viewers', stream_data[i].viewers);
                  streamStamp.set('status', stream_data[i].channel.status);
                  streamStamp.set('game', gameStamps[stream_data[i].game]);
                  streamStamp.set('stream', stream);
                  return streamStamp.save();
                }
              }, function(error) {
                  console.log('There was an error in channel query : '+error);
              }
            )
          );
        })(i);
      }
      return Parse.Promise.when(promises_streams);
    }).then(function() {
      status.success('Success!');
    }, function(error) {
        console.error('ARF, error was : '+error);
        status.error('ERROR, there was an error!')
    });
  });
});

Parse.Cloud.define("getTwitchData", function(request, response) {
  // var StreamData = Parse.Object.extend("StreamData");
  console.error('request is : '+JSON.stringify(request))
  console.error('response is : '+JSON.stringify(response))
  var query = new Parse.Query("StreamData");
  query.equalTo("name", request.params.name);
  query.find({
    success: function(results) {
      console.error('results : '+results)
      response.success(results);
    },
    error: function() {
      response.error("No streamdata was fetched..");
    }
  });
});
