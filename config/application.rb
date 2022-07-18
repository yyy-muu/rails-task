require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.autoload_paths += %W(#{config.root}/validator)

    config.i18n.default_locale = :ja
    config.generators.template_engine = :slim
  
    # アカウント作成失敗時のレイアウト崩れ防止のため、field_with_errorsクラスを読み込まない
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
