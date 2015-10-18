angular.module 'streambacker.main'
  .controller 'MainController', ($scope, channels, games) ->
    $scope.channels = channels
    $scope.games = games
