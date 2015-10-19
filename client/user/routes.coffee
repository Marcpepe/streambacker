angular.module 'streambacker.user'
.config ($stateProvider) ->
  $stateProvider
    .state 'user',
      url: '/users',
      templateUrl: 'user/view.html'
      controller: 'UserController'
      resolve:
        gameStamps: (twitchUser) ->
          return twitchUser.getUsers().$promise
