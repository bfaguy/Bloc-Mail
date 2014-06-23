require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module BlocMail 
  class Application < Rails::Application
    # emails are 'old' / 'stale' after this number of days
    DAYS_OLD_THRESHOLD = 11 
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
