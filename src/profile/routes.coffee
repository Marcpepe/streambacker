angular.module '%module%.profile'
.config ($routeProvider) ->
  $routeProvider.when '/profile',
    templateUrl: 'profile/view.html'
    controller: 'ProfileController'
