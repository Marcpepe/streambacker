Parse.Cloud.job("twitchDataOld", function(request, status) {
  // Parse.Cloud.useMasterKey();
  var StreamData = Parse.Object.extend("StreamData");
  Parse.Cloud.httpRequest({
    url: 'https://api.twitch.tv/kraken/streams',
    params: {
      channel : 'imaqtpie,phantoml0rd,sodapoppin,lirik,riotgames,lirik'
    },
    headers: {
      'Accept': 'application/vnd.twitchtv.v3+json',
      'Content-Type': 'application/json;charset=utf-8',
      'Client-ID': 'kdhloc045kq5oabztj8yf447vw49b5a'
    }
  }).then(function(httpResponse) {
    console.log('Http response text: '+httpResponse.text);
    var data = httpResponse.data["streams"]
    for (var i = 0; i < data.length; i++) {
      var streamData = new StreamData();
      // Stream
      streamData.set('viewers', data[i].viewers)
      streamData.set('status', data[i].channel.status)
      // Streamer
      streamData.set('name', data[i].channel.name)
      // Game
      streamData.set('game', data[i].game)

      streamData.save(null, {
        success: function(streamData) {
          status.message("Saving stream data..");
          status.success("Stream data was saved successfully.");
        },
        error: function(streamData, error) {
          status.error("Stream data was not saved.");
        }
      });
    }
    status.success("Apparently there was no streamer online..");
  }, function(httpResponse) {
    console.error('Arf.. Request failed with response code ' + httpResponse.status);
  });
});

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
  var gameArray = [];
  var gameStampArray = [];

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
      gameArray[i] = new Game();
      gameStampArray[i] = new GameStamp();
      (function(i) {
        // if game exists, check if maxViewerCount/maxChannelsCount (and logo, etc) need update; else create
        var game_query = new Parse.Query(Game);
        game_query.equalTo('twitchId', game_data[i].game._id);

        promises.push(
          game_query.find().then(
            function(results) {
              // console.log('Checking results (i='+i+')..'+JSON.stringify(results));
              if (results.length > 0) {
                // console.log('Game already created');
                gameArray[i] = results[0];
                if (gameArray[i].get('maxViewers') < game_data[i].viewers) {
                  gameArray[i].set('maxViewers', game_data[i].viewers);
                  // console.log('Updated maxViewers!')
                } else {
                  // console.log('maxViewers not reached..')
                }
                if (gameArray[i].get('maxChannels') < game_data[i].channels) {
                  gameArray[i].set('maxChannels', game_data[i].channels);
                  // console.log('Updated maxChannels!')
                } else {
                  // console.log('maxChannels not reached..')
                }

              } else {
                game = new Game();
                // console.log('Game needs to be created');
                // console.log('i vaut : '+i);
                // console.log('game_data[i] : '+JSON.stringify(game_data[i]));
                gameArray[i].set('name', game_data[i].game.name);
                gameArray[i].set('twitchId', game_data[i].game._id);
                gameArray[i].set('maxViewers', game_data[i].viewers);
                gameArray[i].set('maxChannels', game_data[i].channels);
                gameArray[i].set('box', game_data[i].game.box.medium);
              }

              // create gamestamp and attach to game and recording
              gameStampArray[i].set('viewers', game_data[i].viewers);
              gameStampArray[i].set('channels', game_data[i].channels);
              gameStampArray[i].set('game', gameArray[i]);
              gameStampArray[i].set('recording', recording);
              gameStamps[gameArray[i].name] = gameStampArray[i];

              if (i%10==0) {
                console.log('Saving.. (i='+i+')');
              }
              return gameStampArray[i].save(null, {
                success: function() {
                  console.log('gameStampSaved')
                },
                error: function(error) {
                  console.log('there was an error while saving gameStamp : '+error)
                }
              });
              // gameArray[i].save();
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

// }).then(function() {
// console.log("Requesting data for streamers : "+streamers);
    // Parse.Cloud.httpRequest({
      // url: 'https://api.twitch.tv/kraken/streams',
      // params: {
        // channel : streamers
      // },
      // headers: {
        // 'Accept': 'application/vnd.twitchtv.v3+json',
        // 'Content-Type': 'application/json;charset=utf-8',
        // 'Client-ID': 'kdhloc045kq5oabztj8yf447vw49b5a'
      // }
    // }).then(function(res) {
      // console.log('Stream http request successful : '+res.text);
      // var stream_data = res.data["streams"];
      // for (var i = 0; i < stream_data.length; i++) {
        // console.log('yoyo'+i);
        // (function(i) {
          // // if channel exists, check if maxViewers (and logo, etc) need update; else create
          // console.log('Creating stream record for id : '+stream_data[i].game.name);
          // var channel = new Channel();
          // var channel_query = new Parse.Query(Channel);
          // channel_query.equalTo('twitchId', stream_data[i].game._id);
          // channel_query.find().then(function(results) {
            // console.log('Checking channel results..');
            // if (results.length > 0) {
              // console.log('Channel already created');
              // channel = results[0];
              // if (results[0].get('maxViewers') < stream_data[i].viewers) {
                // channel.set('maxViewers', stream_data[i].viewers);
              // }
              // // TODO: add maxViewerStamp
              // // TODO: traffic = viewers / total viewers in twitch for this game
              // // var traffic = ...
              // // if (results[0].get('maxTraffic') < stream_data[i].channels) {
                // // game.set('maxChannels', stream_data[i].channels);
              // // }

            // } else {
              // console.log('Channel needs to be created');
              // channel.set('name', stream_data[i].channel.name);
              // channel.set('display_name', stream_data[i].channel.display_name);
              // channel.set('twitchId', stream_data[i].channel._id);
              // channel.set('maxViewers', stream_data[i].viewers);
              // channel.set('views', stream_data[i].channel.views);
              // channel.set('followers', stream_data[i].channel.followers);
              // // TODO: add partner, language, broadcaster_language, etc..
            // }
            // var streamStamp = new StreamStamp();
            // streamStamp.set('viewers', stream_data[i].viewers);
            // streamStamp.set('status', stream_data[i].channel.status);
            // // Channel
            // streamStamp.set('channel', channel);
            // // Game
            // streamStamp.set('game', gameStamps[stream_data[i].game]);

            // streamStamp.save(null, {
              // success: function(streamStamp) {
                // status.message("Saving streamstamp..");
              // },
              // error: function(streamStamp, error) {
                // status.error("Streamstamp data was not saved.");
              // }
            // });
          // }, function(error) {
              // console.log('Maybe game should be created here, that is if error means results.length is 0');
              // console.log('Errore is : '+error);
            // }
          // );
        // });
      // }
    // });
    // console.log("Stop 3");
    // status.message("Stop 3");



  }).then(function(result) {
    console.log('resultt : '+JSON.stringify(result))
    if (result) {
      status.success('SuccESs!');
    }
  }, function(error) {
      console.error('ARF, error was : '+error);
      status.error('ERROR, there was an error!')
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
