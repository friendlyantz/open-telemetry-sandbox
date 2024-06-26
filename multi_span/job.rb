require 'colorize'

require 'sidekiq'

require 'opentelemetry/sdk'
require 'opentelemetry/instrumentation/sidekiq'
require 'opentelemetry/exporter/jaeger'

ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'SIDEKIQ SERVICE'
  c.use 'OpenTelemetry::Instrumentation::Sidekiq', {
    propagation_style:  :child
  }
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

sleep 2
