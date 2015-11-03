angular.module 'streambacker.user'
.factory 'twitchUser', ($resource) ->
  $resource '/api/user', {},
    getUsers:
      method: 'GET'
      isArray: true

