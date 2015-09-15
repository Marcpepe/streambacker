gulp = require 'gulp'
parameters = require '../../parameters.coffee'

# Copy transaltion JSONs to served dir
gulp.task 'i18n', ->
  gulp.src "#{parameters.i18n.input_path}/**"
  .pipe gulp.dest parameters.i18n.output_path
