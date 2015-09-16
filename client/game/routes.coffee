angular.module 'streambacker.channel'
.config ($routeProvider) ->
  $routeProvider.when '/game/:twitchId',
    templateUrl: 'game/view.html'
    controller: 'GameController'
    resolve:
      gameStamps: (twitchGame) ->
        return twitchGame.getGameStamps().$promise
