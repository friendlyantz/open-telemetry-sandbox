# WIP
## OpenTelemetry libraries
### For starters we just needf SDK which will do the basics
All you need is `opentelemetry/sdk` library to do the basics

## Define where to output the telemetry data
Open Telemetry Output can be to console, or to a collector (OTLP, Zipkin, Jager, etc)

```ruby
ENV['OTEL_TRACES_EXPORTER'] = 'console'
```

## Configure the OpenTelemetry SDK

```ruby
OpenTelemetry::SDK.configure do |c|
  c.service_name = "BASIC SERVICE"
end

MyAppTracer = OpenTelemetry.tracer_provider.tracer('NAME_OF_YOUR_TRACER')

MyAppTracer.in_span("name of the span") do |span|
  # your code here
end
```
