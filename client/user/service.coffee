angular.module 'streambacker.user'
.factory 'twitchUser', ($resource) ->
  $resource '127.0.0.1:1337/user', {},
    getUsers:
      method: 'GET'

