angular.module 'streambacker.user'
  .controller 'UserController', ($scope, users) ->
    $scope.users = users
