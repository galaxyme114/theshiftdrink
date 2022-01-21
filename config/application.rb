require_relative 'boot'
# require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shiftdrink
  class Application < Rails::Application
    require 'ext/string'

    config.autoload_paths += %W(#{config.root}/lib)

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper      false
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

    config.active_job.queue_adapter = :delayed_job
    # config.active_record.raise_in_transactional_callbacks = true
		config.middleware.use Rack::Deflater
  end
end
