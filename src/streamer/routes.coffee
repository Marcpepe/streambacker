angular.module '%module%.streamer'
.config ($stateProvider) ->
  $stateProvide
  .state 'streamer',
    url: '/streamer'
    templateUrl: 'setup/views/setup.html'
    controller: 'SetupCtrl'
