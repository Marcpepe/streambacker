angular.module '%module%.channel'
  .controller 'ChannelController', ($scope, $routeParams, streamStamps) ->
    $scope.twitchId = parseInt $routeParams.twitchId
    $scope.streamStamps = streamStamps
    $scope.channel = streamStamps.results[0].channel
