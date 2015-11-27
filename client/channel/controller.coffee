angular.module 'streambacker.channel'
  .controller 'ChannelController', ($scope, $stateParams, streamStamps) ->
    $scope.twitchId = parseInt $stateParams.twitchId
    $scope.streamStamps = streamStamps.results
    $scope.channel = streamStamps.results[0].stream.channel
    console.log 'YOLOOU'
    # io.socket.get '/message/listen', (body, JWR) ->
    io.socket.get '/message/listen', (body, JWR) ->
      console.log 'Sails responded with: ', body
      console.log 'with headers: ', JWR.headers
      console.log 'and with status code: ', JWR.statusCode

