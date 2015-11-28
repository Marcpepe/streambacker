angular.module 'streambacker.main'
  .controller 'MainController', ($scope, channels, games, hostname) ->
    $scope.channels = channels
    $scope.games = games
    $scope.hostname = hostname.name
