angular.module '%module%.profile'
.config ($stateProvider) ->
  $stateProvider
  .state 'profile',
    url: '/profile'
    templateUrl: 'profile/view.html'
    controller: 'ProfileController'
