require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/rack'
require 'opentelemetry/exporter/zipkin'
require 'opentelemetry/exporter/jaeger'
require 'opentelemetry/exporter/zipkin'
require 'rack'

$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'rackroll'

use Rack::Reloader # will reload 'requirred' files on each request, but won't apply to this config changes

ENV['OTEL_TRACES_EXPORTER'] = 'jaeger'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'RackRoll'
  c.use 'OpenTelemetry::Instrumentation::Rack'
end

# integration should be automatic in web frameworks (like rails),
# but for a plain Rack application, enable it in your config.ru, e.g.,
use OpenTelemetry::Instrumentation::Rack::Middlewares::TracerMiddleware # This should go after SDK.configure

run RackRoll.new
