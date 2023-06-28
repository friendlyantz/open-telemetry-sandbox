# frozen_string_literal: true

require "bundler/setup"
Bundler.require(:default)

# loader = Zeitwerk::Loader.new
# loader.push_dir(File.join(__dir__, "../config"))
# loader.push_dir(File.join(__dir__, "../app/jobs"))
# loader.enable_reloading
# loader.setup

Sidekiq.configure_client do |config|
  config.redis = {db: 1}
end

Sidekiq.configure_server do |config|
  config.redis = {db: 1}
end
