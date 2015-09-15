gulp = require 'gulp'
parameters = require '../../parameters.coffee'

coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
sourcemaps = require 'gulp-sourcemaps'
gutil = require 'gulp-util'

# Compile CoffeeScript files to JS
# `module.coffee` files are treated before others so all the modules are declared before being used
coffeeFiles = [
  "#{parameters.app_path}/**/module.coffee"
  "#{parameters.app_path}/**/*.coffee"
]

gulp.task 'coffee', ->
  gulp.src coffeeFiles
  .pipe plumber()
  .pipe if gutil.env.dev then sourcemaps.init() else gutil.noop()
  .pipe coffee()
  .pipe concat parameters.app_main_file
  .pipe if gutil.env.dev then sourcemaps.write() else gutil.noop()
  .pipe gulp.dest "#{parameters.web_path}/js"
