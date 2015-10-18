gulp = require 'gulp'
parameters = require '../../parameters.coffee'

# Copy fonts to the served dir
gulp.task 'fonts', ->
  gulp.src parameters.fonts.input_paths
  .pipe gulp.dest parameters.fonts.output_path
