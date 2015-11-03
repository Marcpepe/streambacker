parameters = require '../../../devops/build/parameters'

module.exports = (config) ->
  config.set
    basePath: '../../../'

    files: [
      "#{parameters.web_path}/js/vendor.js"
      "#{parameters.web_path}/js/templates.js"
      # Include later when mocking is needed
      # 'bower_components/angular-mocks/angular-mocks.js'
      # 'bower_components/should/should.js'
      "#{parameters.app_path}/main.coffee"
      "#{parameters.app_path}/**/*module*.coffee"
      "#{parameters.app_path}/**/*.jade"
      "#{parameters.app_path}/**/*.coffee"
      'test/client/unit/**/*.coffee'
      # { pattern: 'test/client/data/*.json' }
    ]

    frameworks: [
      'mocha'
      # 'chai'
      # 'fixture'
    ]

    plugins: [
      'karma-firefox-launcher'
      # 'karma-chrome-launcher'
      'karma-mocha'
      # 'karma-chai'
      'karma-ng-jade2js-preprocessor'
      'karma-coffee-preprocessor'
      # 'karma-coverage'
      # 'karma-fixture'
      # 'karma-json-fixtures-preprocessor'
    ]

    preprocessors:
      'test/client/unit/**/*.coffee': 'coffee'
      # 'test/client/data/*.json': 'json_fixtures'
      'client/**/*.coffee': 'coffee'
      'client/**/*.jade': 'ng-jade2js'

    ngJade2JsPreprocessor:
      stripPrefix: 'src/'
      moduleName: parameters.templates_module

    # jsonFixturesPreprocessor:
      # variableName: '__json__'

    reporters: [
      'dots'
      # 'coverage'
    ]

    browsers: [
      'Firefox'
      # 'Chrome'
    ]

    # coverageReporter:
      # dir: 'test/coverage-front'
      # type: 'html'

    autoWatch: true

