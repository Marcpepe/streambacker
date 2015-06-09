angular.module '%module%.main'
.config ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: 'main/view.html'
    controller: 'MainController'
    resolve:
      channels: (twitchMain) ->
        return twitchMain.getChannels().$promise
      games: (twitchMain) ->
        return twitchMain.getGames().$promise
