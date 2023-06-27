require 'colorize'

require 'sidekiq'

require 'opentelemetry/sdk'
require 'opentelemetry/exporter/jaeger'
require 'opentelemetry/instrumentation/sidekiq'

ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'SIDEKIQ SERVICE'
  c.use 'OpenTelemetry::Instrumentation::Sidekiq'
end

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class CoolJob
  include Sidekiq::Worker

  def perform
    puts "I'm doing something super hard!".light_red
    sleep 2.01 # sleep before error for Jaeger to catch up
    raise 'Overworked Error!' if rand(3).zero?

    puts "I've finished doing something super hard!".red
  end
end
