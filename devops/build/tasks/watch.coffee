gulp = require 'gulp'
parameters = require '../parameters.coffee'

# Watch for changes an provide a proxy server to the vagrant box that supports livereload
gulp.task 'watch', ['build'], ->
  gulp.watch "#{parameters.app_path}/**/*", ['compile']
  gulp.watch 'bower_components', ['copy']

