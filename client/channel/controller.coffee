angular.module 'streambacker.channel'
  .controller 'ChannelController', ($scope, $stateParams, streamStamps) ->
    $scope.twitchId = parseInt $stateParams.twitchId
    $scope.streamStamps = streamStamps.results
    $scope.channel = streamStamps.results[0].stream.channel
