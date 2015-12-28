gulp = require 'gulp'
parameters = require '../../parameters.coffee'

typescript = require 'gulp-typescript'
concat = require 'gulp-concat'
plumber = require 'gulp-plumber'
sourcemaps = require 'gulp-sourcemaps'
gutil = require 'gulp-util'


gulp.task 'typescript', ->
  gulp.src "#{parameters.app_path}/**/*.ts"
  .pipe plumber()
  .pipe if gutil.env.dev then sourcemaps.init() else gutil.noop()
  .pipe typescript({
    "target": "ES5",
    "module": "system",
    "moduleResolution": "node",
    "sourceMap": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "removeComments": false,
    "noImplicitAny": false
  })
  # .pipe concat parameters.app_main_file
  .pipe if gutil.env.dev then sourcemaps.write() else gutil.noop()
  .pipe gulp.dest "#{parameters.web_path}/"


# GULP TASK WHICH CONCATENATES ALL BUT BOOT.JS IN ONE FILE APP.JS
# gulp.task 'typescript', ->
  # # gulp.src "#{parameters.app_path}/app/boot.ts"
  # gulp.src "#{parameters.app_path}/app/boot.ts"
  # .pipe plumber()
  # .pipe if gutil.env.dev then sourcemaps.init() else gutil.noop()
  # .pipe typescript({
    # "target": "ES5",
    # "module": "system",
    # "moduleResolution": "node",
    # "sourceMap": true,
    # "emitDecoratorMetadata": true,
    # "experimentalDecorators": true,
    # "removeComments": false,
    # "noImplicitAny": false
  # })
  # # .pipe concat parameters.app_main_file
  # .pipe concat "boot.js"
  # .pipe if gutil.env.dev then sourcemaps.write() else gutil.noop()
  # .pipe gulp.dest "#{parameters.web_path}/app"
  # gulp.src "#{parameters.app_path}/app/app.component.ts"
  # .pipe plumber()
  # .pipe if gutil.env.dev then sourcemaps.init() else gutil.noop()
  # .pipe typescript({
    # "target": "ES5",
    # "module": "system",
    # "moduleResolution": "node",
    # "sourceMap": true,
    # "emitDecoratorMetadata": true,
    # "experimentalDecorators": true,
    # "removeComments": false,
    # "noImplicitAny": false
  # })
  # # .pipe concat parameters.app_main_file
  # .pipe concat "app.component.js"
  # .pipe if gutil.env.dev then sourcemaps.write() else gutil.noop()
  # .pipe gulp.dest "#{parameters.web_path}/app"



# TRIED USING EXTERNAL TSCONFIG.JSON..

# typescriptFiles = [
  # # "#{parameters.app_path}/**/module.ts"
  # "#{parameters.app_path}/**/*.ts"
# ]
# tsProject = typescript.createProject "#{parameters.build_path}/tsconfig.json"

# gulp.task 'typescript', ->
  # # tsResult = tsProject.src(typescriptFiles).pipe(plumber()).pipe(if gutil.env.dev then sourcemaps.init() else gutil.noop()).pipe(typescript(tsProject))
  # # tsResult.js.pipe(concat(parameters.app_main_file)).pipe(if gutil.env.dev then sourcemaps.write() else gutil.noop()).pipe(gulp.dest("#{parameters.web_path}/js"))
  # # tsResult = gulp.src('lib/*.ts').pipe(sourcemaps.init()).pipe(ts(sortOutput: true))
  # # tsResult.js.pipe(concat('output.js')).pipe(sourcemaps.write()).pipe gulp.dest('release/js')

  # tsResult = tsProject.src "#{parameters.app_path}/**/*.ts"
  # # tsResult = tsProject.src typescriptFiles
  # # .pipe plumber()
  # .pipe if gutil.env.dev then sourcemaps.init() else gutil.noop()
  # .pipe typescript(tsProject)
  # tsResult.js
  # .pipe concat parameters.app_main_file
  # .pipe if gutil.env.dev then sourcemaps.write() else gutil.noop()
  # .pipe gulp.dest "#{parameters.web_path}/js"
