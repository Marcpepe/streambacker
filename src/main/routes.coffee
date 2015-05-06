angular.module '%module%.main'
.config ($routeProvider) ->
  $routeProvider
    .when '/',
    templateUrl: 'view.html'
    controller: 'MainController'
