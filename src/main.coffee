###*
  @ngdoc module
  @name %module%
  @module %module%
  @description

  This module requires all submodules of your app
###

angular.module '%module%', [
  'ngMaterial'
  'ngRoute'
  '%module%.main'
  '%module%.channel'
]
