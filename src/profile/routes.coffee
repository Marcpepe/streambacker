angular.module '%module%.profile'
.config ($routeProvider) ->
  $routeProvider.when '/profile/:twitchId',
    templateUrl: 'profile/view.html'
    controller: 'ProfileController'
