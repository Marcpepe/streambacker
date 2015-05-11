angular.module '%module%.profile'
  .controller 'ProfileController', ($scope, $routeParams, TwitchData) ->
    $scope.id = $routeParams.id
    $scope.data = TwitchData.getLirik()
