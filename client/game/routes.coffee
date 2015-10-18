angular.module 'streambacker.channel'
.config ($stateProvider) ->
  $stateProvider
    .state 'game',
      url: '/game/:twitchId',
      templateUrl: 'game/view.html'
      controller: 'GameController'
      resolve:
        gameStamps: (twitchGame) ->
          return twitchGame.getGameStamps().$promise
