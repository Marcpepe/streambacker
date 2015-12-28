gulp = require 'gulp'
parameters = require '../../parameters.coffee'

# Copy transaltion JSONs to served dir
gulp.task 'system', ->
  gulp.src "#{parameters.app_path}/app/system.js"
  .pipe gulp.dest "#{parameters.web_path}/js"
