# 'use strict'
# browserify = require 'browserify'
# gulp = require 'gulp'
# source = require 'vinyl-source-stream'
# buffer = require 'vinyl-buffer'
# globby = require 'globby'
# through = require 'through2'
# gutil = require 'gulp-util'
# uglify = require 'gulp-uglify'
# sourcemaps = require 'gulp-sourcemaps'
# # reactify = require 'reactify'

# gulp.task 'javascript', ->
  # # gulp expects tasks to return a stream, so we create one here.
  # bundledStream = through()
  # bundledStream
    # .pipe source 'app.js'
    # .pipe buffer()
    # .pipe sourcemaps.init loadMaps: true
    # .pipe uglify()
      # .on 'error', gutil.log
    # .pipe sourcemaps.write './'
    # .pipe gulp.dest "#{parameters.web_path}/js"
  # # "globby" replaces the normal "gulp.src" as Browserify
  # # creates it's own readable stream.
  # globby [
    # '../../../node_modules/*.js'
    # '../../../node_modules/*.js'
  # ]
  # .then((entries) ->
		# # create the Browserify instance.
		# b = browserify(
			# entries: entries
			# debug: true
			# # transform: [ reactify ])
		# # pipe the Browserify stream into the stream we created earlier
		# # this starts our gulp pipeline.
		# b.bundle().pipe bundledStream
		# return
  # ).catch (err) ->
    # # ensure any errors from globby are handled
    # bundledStream.emit 'error', err
    # return
  # # finally, we return the stream, so gulp knows when this task is done.
  # bundledStream



gulp = require 'gulp'
parameters = require '../../parameters.coffee'

# mainBowerFiles = require 'main-bower-files'
concat = require 'gulp-concat'
filter = require 'gulp-filter'

# JS vendors will be read from bower.json order and concatenate into [web_path]/js/[vendor_main_file]

gulp.task 'vendors', ->
	# Scripts
  gulp.src([
    'node_modules/angular2/bundles/angular2-polyfills.js'
    'node_modules/systemjs/dist/system.src.js'
    'node_modules/rxjs/bundles/Rx.js'
    'node_modules/angular2/bundles/angular2.dev.js'
    'node_modules/angular2-material-build/angular2_material.dev.js'
  ]).pipe(concat(parameters.vendor_main_file)).pipe(gulp.dest("#{parameters.web_path}/js"))
	# Styles
  gulp.src([
    'node_modules/angular2-material-build/angular2_material.css'
    'node_modules/font-awesome/css/font-awesome.min.css'
  ]).pipe(concat(parameters.vendor_css_main_file)).pipe(gulp.dest("#{parameters.web_path}/css"))
	# Fonts
  gulp.src([
    'node_modules/font-awesome/fonts/*'
    'no'
  ]).pipe(gulp.dest("#{parameters.web_path}/fonts"))
	# .pipe filter [
			# '**/*.woff'
			# '**/*.svg'
			# '**/*.eot'
			# '**/*.ttf'
			# '**/*.otf'
		# ]
	# .pipe gulp.dest "#{parameters.web_path}/fonts"
