# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  # Add additional load paths for your own custom dirs
  config.load_paths += %W( #{RAILS_ROOT}/app/apis )

  config.gem "lipsiadmin",  :version => "< 5.0"
  config.gem "coderay",     :lib => "coderay"
  config.gem "datanoise-actionwebservice", :lib => "actionwebservice", :source => "http://gems.github.com"
  config.frameworks -= [ :active_resource ]

  config.active_record.timestamped_migrations = false
  config.time_zone = 'Rome'
  config.i18n.default_locale = :en
end