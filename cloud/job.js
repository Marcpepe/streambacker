Parse.Cloud.job("twitchData", function(request, status) {
  // Parse.Cloud.useMasterKey();
  var StreamData = Parse.Object.extend("StreamData");
  Parse.Cloud.httpRequest({
    url: 'https://api.twitch.tv/kraken/streams',
    params: {
      channel : 'imaqtpie,phantoml0rd,kolento,lirik,riotgames'
    }
    headers: {
      'Accept': 'application/vnd.twitchtv.v3+json',
      'Content-Type': 'application/json;charset=utf-8',
      'Client-ID': 'kdhloc045kq5oabztj8yf447vw49b5a'
    }
  }).then(function(httpResponse) {
    console.log('Http response text: '+httpResponse.text);
    var data = httpResponse.data;
    for (var i = 0; i < data.length; i++){
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
          console.log('Ok, stream data saved.')   
          alert('Yep, stream data saved.')
          status.message("Saving stream data..");
          status.success("Stream data was saved successfully.");
        },
        error: function(streamData, error) {
          console.log('Ko, stream data not saved.')   
          alert('Nop, stream data not saved.')
          status.error("Stream data was not saved.");
        }
      });
    }
  }, function(httpResponse) {
    console.error('Arf.. Request failed with response code ' + httpResponse.status);
  });
});
