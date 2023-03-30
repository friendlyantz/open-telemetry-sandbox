require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/rack'
require 'opentelemetry/exporter/zipkin'

ENV['OTEL_TRACES_EXPORTER'] = 'zipkin'
OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Rack'
end

# integration should be automatic in web frameworks (like rails),
# but for a plain Rack application, enable it in your config.ru, e.g.,
use OpenTelemetry::Instrumentation::Rack::Middlewares::TracerMiddleware

run do |env|
  [200, {}, ["Hello World"]]
end
