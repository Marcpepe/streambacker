gulp = require 'gulp'
parameters = require '../parameters.coffee'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'

gulp.task 'lb-services', ->
  gulp.src "#{parameters.paths.loopback.backend_main_file}"
  .pipe require('gulp-loopback-sdk-angular')
    apiUrl: "#{parameters.paths.loopback.backend_route}"
  .pipe rename 'lb-services.js'
  .pipe uglify()
  .pipe sourcemaps.init()
  .pipe sourcemaps.write()
  .pipe gulp.dest "#{parameters.paths.www.mainPath}/js"
  .once 'end', ->
    console.log 'ENNEDDDED'
    # process.exit()
