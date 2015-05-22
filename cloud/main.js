Parse.Cloud.job("twitchData", function(request, status) {
  var streamers = 'imaqtpie,phantoml0rd,sodapoppin,lirik,riotgames,kolento,trumpsc'
  // iterate through streamers. If doesn't exists, create
});

Parse.Cloud.job("twitchData", function(request, status) {
  // Streamer list
  var streamers = 'imaqtpie,phantoml0rd,sodapoppin,lirik,riotgames,kolento,trumpsc'

  // Parse.Cloud.useMasterKey();
  var Recording = Parse.Object.extend("Recording");
  var Game = Parse.Object.extend("Game");
  var GameStamp = Parse.Object.extend("GameStamp");
  var Channel = Parse.Object.extend("Channel");
  var Stream = Parse.Object.extend("Stream");
  var StreamStamp = Parse.Object.extend("StreamStamp");


  Parse.Cloud.httpRequest({
    url: 'https://api.twitch.tv/kraken/games/top?limit=100&offset=0',
    headers: {
      'Accept': 'application/vnd.twitchtv.v3+json',
      'Content-Type': 'application/json;charset=utf-8',
      'Client-ID': 'kdhloc045kq5oabztj8yf447vw49b5a'
    }
  }).then(function(httpResponse) {
    console.log('Games http request successful : '+httpResponse.text);
    var game_data = httpResponse.data["top"];
    var recording = new Recording();
    var gameStamps = {}
    for (var i = 0; i < game_data.length; i++) {
      var game = new Game();
      // if game exists, check if maxViewerCount/maxChannelsCount (and logo, etc) need update; else create
      var game_query = new Parse.Query(Game);
      game_query.equalTo('twitchId', game_data[i].game._id);
      query.find({
        success: function(results) {
          console.log('Checking results..');
          if (results.length > 0) {
            console.log('Game already created');
            game = results[0];
            if (results[0].get('maxViewers') < game_data[i].viewers) {
              game.set('maxViewers', game_data[i].viewers);
            }
            if (results[0].get('maxChannels') < game_data[i].channels) {
              game.set('maxChannels', game_data[i].channels);
            }

          } else {
            console.log('Game needs to be created');
            game.set('name', game_data[i].game.name);
            game.set('twitchId', game_data[i].game._id);
            game.set('maxViewers', game_data[i].viewers);
            game.set('maxChannels', game_data[i].channels);
            game.set('box', game_data[i].game.box.medium);
          }
        }
        error: function(error) {
          console.log('Maybe game should be created here, that is if error means results.length is 0')
        }
      });
      // create gamestamp and attach to game and recording
      var gameStamp = new GameStamp();
      gameStamp.set('viewers', game_data[i].viewers);
      gameStamp.set('channels', game_data[i].channels);
      gameStamp.set('game', game);
      gameStamp.set('recording', recording);
      gameStamps[game.name] = gameStamp;

      gameStamp.save();
    }
    console.log "Requesting data for streamers : ", streamers
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
      console.log('Stream http request successful : '+httpResponse.text);
      var stream_data = res.data["streams"]
      for (var i = 0; i < stream_data.length; i++) {
        // if channel exists, check if maxViewers (and logo, etc) need update; else create
        var channel = new Channel();
        var channel_query = new Parse.Query(Channel);
        channel_query.equalTo('twitchId', stream_data[i].game._id);
        query.find({
          success: function(results) {
            console.log('Checking channel results..');
            if (results.length > 0) {
              console.log('Channel already created');
              channel = results[0];
              if (results[0].get('maxViewers') < stream_data[i].viewers) {
                channel.set('maxViewers', stream_data[i].viewers);
              }
              // TODO: add maxViewerStamp
              // TODO: traffic = viewers / total viewers in twitch for this game
              // var traffic = ...
              // if (results[0].get('maxTraffic') < stream_data[i].channels) {
                // game.set('maxChannels', stream_data[i].channels);
              // }

            } else {
              console.log('Channel needs to be created');
              channel.set('name', stream_data[i].channel.name);
              channel.set('display_name', stream_data[i].channel.display_name);
              channel.set('twitchId', stream_data[i].channel._id);
              channel.set('maxViewers', stream_data[i].viewers);
              channel.set('views', stream_data[i].channel.views);
              channel.set('followers', stream_data[i].channel.followers);
              // TODO: add partner, language, broadcaster_language, etc..
            }
            var streamStamp = new StreamStamp();
            streamStamp.set('viewers', stream_data[i].viewers);
            streamStamp.set('status', stream_data[i].channel.status);
            // Channel
            streamStamp.set('channel', channel);
            // Game
            streamStamp.set('game', gameStamps[stream_data[i].game]);

            streamStamp.save(null, {
              success: function(streamStamp) {
                status.message("Saving streamstamp..");
              },
              error: function(streamStamp, error) {
                status.error("Streamstamp data was not saved.");
              }
            });
          }
          error: function(error) {
            console.log('Maybe game should be created here, that is if error means results.length is 0')
          }
        });

      }
      if (stream_data.length == 0) {
        status.success("Apparently there was no streamer online..");
      } else {
        status.success("Stream data was saved successfully.");
      }
    }, function(res) {
      console.error('Arf.. Streams request failed with response code ' + res.status);
    });
  }, function(httpResponse) {
    console.error('Arf.. Games request failed with response code ' + httpResponse.status);
  });

  status.success("Games saved and updated successfully");

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
