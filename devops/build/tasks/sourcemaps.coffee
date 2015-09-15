gulp = require 'gulp'
parameters = require '../parameters.coffee'

sourcemaps = require 'gulp-sourcemaps'

gulp.task 'sourcemaps', ['minify'], ->
  gulp.src ["#{parameters.web_path}/**/*.js", "#{parameters.web_path}/**/*.css"]
  .pipe sourcemaps.init()
  .pipe sourcemaps.write()
  .pipe gulp.dest parameters.web_path
