angular.module 'streambacker.main'
.config ($stateProvider) ->
  $stateProvider
    .state 'main',
      url: '/'
      # template: '<p>Helloooo</p>'
      templateUrl: 'main/view.html'
      # controller: 'MainController'
      # resolve:
        # channels: (twitchMain) ->
          # return twitchMain.getChannels().$promise
        # games: (twitchMain) ->
          # return twitchMain.getGames().$promise
