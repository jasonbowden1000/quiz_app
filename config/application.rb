require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QuizApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.application_name = 'QuizApp'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.x.question_type.MULTIPLE_CHOICE = 0
    config.x.question_type.MULTIPLE_ANSWER = 1
    config.x.question_type.WRITTEN = 2
    config.x.attempt_status.IN_PROGRESS = 0
    config.x.attempt_status.FINISHED = 1
  end
end
