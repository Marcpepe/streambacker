angular.module '%module%.channel'
.config ($routeProvider) ->
  $routeProvider.when '/game/:twitchId',
    templateUrl: 'game/view.html'
    controller: 'GameController'
