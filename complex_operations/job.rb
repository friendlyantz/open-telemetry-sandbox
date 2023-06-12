require 'sidekiq'
require 'colorize'

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

  def perform(complexity)
    case complexity
    when "super_hard"
      puts "I'm doing something super hard!".red
      1_000_000.times { |i| OpenSSL::Digest::MD5.hexdigest(complexity + i.to_s) } # Very Sophisticated Data Analysis!
      raise "Overworked Error!" if rand(3).zero?
      sleep 1.01
      puts "I've finished doing something super hard!".red
    when "hard"
      100_000.times { |i| OpenSSL::Digest::MD5.hexdigest(complexity + i.to_s) }
      puts "I'm doing something hard!".yellow
    else
      10_000.times { |i| OpenSSL::Digest::MD5.hexdigest(complexity + i.to_s) }
      puts "I'm doing something simple!".green
    end
  end
end
