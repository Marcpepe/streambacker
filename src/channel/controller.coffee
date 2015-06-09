angular.module '%module%.channel'
  # .controller 'ChannelController', ($scope, $routeParams, $http) ->
  .controller 'ChannelController', ($scope, $routeParams, streamStamps) ->
    $scope.twitchId = parseInt $routeParams.twitchId
    $scope.streamStamps = streamStamps
