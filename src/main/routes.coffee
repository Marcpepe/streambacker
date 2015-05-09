angular.module '%module%.main'
.config ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: 'main/view.html'
    controller: 'MainController'
