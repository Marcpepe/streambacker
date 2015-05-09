angular.module '%module%.main'
  .controller 'MainController', ($scope) ->
    console.log "main!"
    $scope.streamers = [
        "id"   : 1
        "name" : "Kolento"
      ,
        "id"   : 2
        "name" : "Trump"
      ,
        "id"   : 3
        "name" : "Sodapoppin"
    ]
