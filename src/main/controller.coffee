angular.module '%module%.main'
  .controller 'MainController', ($scope) ->
    console.log "main!"
    $scope.name = 'Kolento'
