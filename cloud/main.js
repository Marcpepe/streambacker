Parse.Cloud.job("twitchData", function(request, status) {
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

Parse.Cloud.define("getTwitchData", function(request, response) {
  // var StreamData = Parse.Object.extend("StreamData");
  var query = new Parse.Query("StreamData");
  query.equalTo("name", request.params.name);
  for (var j = 0; j < request.params.length; j++) {
    console.error('prname is : '+j+' : '+request.params[j])
  }
  query.find({
    success: function(results) {
      console.error('this should be full : '+results)
      response.success(results);
    },
    error: function() {
      response.error("No streamdata was fetched..");
    }
  });
});
