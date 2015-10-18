angular.module 'streambacker.main'
.config ($stateProvider) ->
  $stateProvider
    .state 'main',
      url: '/'
      templateUrl: 'main/view.html'
      controller: 'MainController'
      resolve:
        channels: (twitchMain) ->
          return twitchMain.getChannels().$promise
        games: (twitchMain) ->
          return twitchMain.getGames().$promise
