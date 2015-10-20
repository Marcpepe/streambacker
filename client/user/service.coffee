angular.module 'streambacker.user'
.factory 'twitchUser', ($resource) ->
  $resource '/user', {},
    getUsers:
      method: 'GET'
      isArray: true

