angular.module '%module%.main'
  .controller 'MainController', ($scope, Twitch) ->
    $scope.channels = Twitch.getChannels()
    $scope.games = Twitch.getGames()
