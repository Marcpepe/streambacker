angular.module '%module%.profile'
  .controller 'ProfileController', ($scope) ->
    console.log "profile!"
    $scope.name = 'Trump'
