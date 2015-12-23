angular.module 'streambacker.main'
  # .controller 'MainController', ($scope, channels, games, hostname) ->
  .controller 'MainController', ($scope, hostname) ->
    # $scope.channels = channels
    # $scope.games = games
    $scope.hostname = hostname.name
  .controller 'RegistrationController', ($scope) ->
    $scope.user = {}

