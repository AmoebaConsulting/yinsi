# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'bundler'
Bundler.require
require 'sugarcube-common'
require 'sugarcube-awesome'
require 'motion-cocoapods'

require './lib/app_properties'
props = AppProperties.new


Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = props.name
  app.deployment_target = props.deployment_target
  app.identifier = props.identifier

  app.version = props.version
  app.short_version = props.version #required to be incremented for AppStore (http://iconoclastlabs.com/cms/blog/posts/updating-a-rubymotion-app-store-submission)
  app.device_family = props.devices
  #app.icons = props.icons
  #app.provisioning_profile = props.provisioning

  app.fonts = ['Lato-Regular.ttf', 'Lato-Bold.ttf', 'Lato-Italic.ttf']

  app.release do
    app.codesign_certificate = props.distribution_certificate
    app.info_plist['API'] = "http://api.yinsiapp.com"
  end

  app.development do
    # app.codesign_certificate = props.developer_certificate
    app.info_plist['API'] = "http://localhost:3000"
  end

  # include external files
  app.files += props.render_files(app)

  app.frameworks += props.frameworks
  app.prerendered_icon = props.prerendered_icon

  # workaround for a RM bug and Bubblewrap, should be solved in the next RM release
  #app.detect_dependencies = false

  # Ensure that our model libraries are available
  model_deps = Dir['app/models/*'].inject({}) do |deps, model|
    deps.merge({ model => 'lib/restful_model.rb'})
  end
  app.files_dependencies model_deps

  # CoaoaPods Dependency Management
  app.pods do
    pod 'SVProgressHUD', :git => "https://github.com/samvermette/SVProgressHUD.git"
    pod 'FontAwesomeKit', :git => "https://github.com/PrideChung/FontAwesomeKit.git"
    pod 'FlatUIKit', :git => "https://github.com/Grouper/FlatUIKit.git", :tag => "1.2"
    pod 'pjsip', :git => "https://github.com/AmoebaConsulting/pjsip.git"
    pod 'gossip', :git => "https://github.com/AmoebaConsulting/gossip.git", :branch => "podified"
  end
end
