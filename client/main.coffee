###*
  @ngdoc module
  @name streambacker
  @module streambacker
  @description

  This module requires all submodules of your app
###

angular.module 'streambacker', [
  'ngMaterial'
  'ui.router'
  'streambacker.templates'
  'streambacker.main'
  'streambacker.channel'
  'streambacker.game'
  'streambacker.user'
]
