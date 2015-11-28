angular.module 'streambacker'
.factory 'hostnameFetcher', ($resource, ENV) ->
  $resource ENV.apiEndPoint, {},
    getHostname:
      method: 'GET'
