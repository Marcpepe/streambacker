angular.module '%module%.profile'
.config ($routeProvider) ->
  $routeProvider.when '/profile/:id',
    templateUrl: 'profile/view.html'
    controller: 'ProfileController'
