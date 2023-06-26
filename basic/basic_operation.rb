require 'opentelemetry/sdk'

ENV['OTEL_TRACES_EXPORTER'] = 'console'

OpenTelemetry::SDK.configure do |c|
  c.service_name = "BASIC SERVICE"
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('LadidaTracer')


MyAppTracer.in_span("basic work") do |span|
  require 'colorize'
  puts "Doing some work!".light_red
  sleep(6.3)
  puts "Made it!!!!!!!!!".green
  puts "================".red
end
