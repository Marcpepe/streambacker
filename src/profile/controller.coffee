angular.module '%module%.profile'
  .controller 'ProfileController', ($scope, $routeParams) ->
    console.log "profile!"
    $scope.id = $routeParams.id
