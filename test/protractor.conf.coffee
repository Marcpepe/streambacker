process.env.HOST ?= 'http://localhost:8000'

module.exports.config =
  framework: 'cucumber'
  seleniumServerJar: '../node_modules/protractor/selenium/selenium-server-standalone-2.45.0.jar'

  specs: [
    'features/*.feature'
  ]

  capabilities:
    browserName: process.env.BROWSER || 'chrome'
