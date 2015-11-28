angular.module 'streambacker.main'
.config ($stateProvider) ->
  $stateProvider
    .state 'main',
      url: '/'
      templateUrl: 'main/view.html'
      controller: 'MainController'
      resolve:
        hostname: (hostnameFetcher) ->
          return hostnameFetcher.getHostname().$promise
        channels: (twitchMain) ->
          return twitchMain.getChannels().$promise
        games: (twitchMain) ->
          return twitchMain.getGames().$promise
