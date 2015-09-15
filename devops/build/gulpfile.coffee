gulp = require 'gulp'
runSequence = require 'run-sequence'

requireDir = require 'require-dir'
dir = requireDir './tasks'

# Build tasks
gulp.task 'build', (done) ->
  runSequence 'clean', ['copy', 'compile'], done

gulp.task 'build-production', (done) ->
  runSequence 'build', ['minify', 'sourcemaps'], done
