angular.module 'streambacker.game'
  .controller 'GameController', ($scope, $stateParams, gameStamps) ->
    $scope.twitchId = parseInt $stateParams.twitchId
    $scope.gameStamps = gameStamps.results
    $scope.game = gameStamps.results[0].game
