app_path = 'client'
# server_path = 'server'
web_path = 'web'

config =

  app_route: '/streambacker'
  backend_route: '/streambacker/api'

  app_path: app_path
  # server_path: server_path
  web_path: web_path
  vendor_path: 'vendor'
  assets_path: "#{app_path}/assets"
  build_temp_path: 'devops/build/temp'

  app_main_file: 'app.js'
  # backend_main_file: 'server/server.coffee'
  css_main_file: 'app.css'
  vendor_css_main_file: 'vendor.css'
  less_main_file: "#{app_path}/main.less"
  templates_file: 'templates.js'
  templates_module: 'streambacker.templates'
  vendor_main_file: 'vendor.js'
  i18n:
    input_path: "#{app_path}/i18n"
    output_path: "#{web_path}/i18n"
  fonts:
    input_paths: [
      'bower_components/font-awesome/fonts/*'
      'bower_components/bootstrap/fonts/*'
    ]
    output_path: "#{web_path}/css/fonts"

module.exports = config
