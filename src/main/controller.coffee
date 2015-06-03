angular.module '%module%.main'
  .controller 'MainController', ($scope, Twitch) ->
    console.log "main!"
    $scope.channels = Twitch.getChannels()
    # $scope.channels = [
        # "id"   : 1
        # "name" : "Kolento"
      # ,
        # "id"   : 2
        # "name" : "Trump"
      # ,
        # "id"   : 3
        # "name" : "Sodapoppin"
    # ]
