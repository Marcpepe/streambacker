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
    var game_data = httpResponse.data["top"]
    for (var i = 0; i < game_data.length; i++) {
      var game = new Game();
      // if game exists, check is maxViewerCount/maxChannelsCount (and logo, etc) need update; else create
      var game_query = new Parse.Query(Game)
      game_query.equalTo('twitchId', game_data[i].game._id)
      query.find({
        success: function(results) {
          console.log('Checking results..')
          if (results.length > 0) {
            console.log('Game already created')
            if (results[0].get('maxViewers') < game_data[i].viewers) {
              game.set('maxViewer', game_data[i].viewers)
            }
            if (results[0].get('maxChannels') < game_data[i].channels) {
              game.set('maxChannels', game_data[i].channels)
            }

          } else {
            console.log('Game needs to be created')
            game.set('name', game_data[i].game.name)
            game.set('twitchId', game_data[i].game._id)
            game.set('maxViewers', game_data[i].viewers)
            game.set('maxChannels', game_data[i].channels)
            game.set('box', game_data[i].game.box.medium)
          }
        }
        error: function(error) {
          console.log('Maybe game should be created here, that is if error means results.length is 0')
        }
      });
      // create recording
      // create gamestamp and attach to game and recording
      var recording = new Recording();
      var gameStamp = new GameStamp();

      streamData.set('game', data[i].game)

      streamData.save(null, {
        success: function(streamData) {
          status.message("Saving stream data..");
        },
        error: function(streamData, error) {
          status.error("Stream data was not saved.");
        }
      });
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
      console.log('Http request successful : '+httpResponse.text);
      var data = res.data["streams"]
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
          },
          error: function(streamData, error) {
            status.error("Stream data was not saved.");
          }
        });
      }
      if (data.length == 0) {
        status.success("Apparently there was no streamer online..");
      } else {
        status.success("Stream data was saved successfully.");
      } 
    }, function(res) {
      console.error('Arf.. Request failed with response code ' + res.status);
    });
    status.success("Games saved and updated successfully");
  }, function(httpResponse) {
    console.error('Arf.. Games request failed with response code ' + httpResponse.status);
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
