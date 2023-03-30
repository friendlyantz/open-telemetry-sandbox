# Prerequisites

- Docker (or [Colima](https://github.com/abiosoft/colima) as a free alternative to run docker command)
- Docker Hub account

# Steps
## 1. Login to Docker Hub
```bash
docker login
```
## 2. Build & Start Tracing backend (i.e. Zipkin)
```bash
docker run --rm -d -p 9411:9411 --name zipkin openzipkin/zipkin
```
this will spin up a zipkin with UI on 
[http://localhost:9411/zipkin/](http://localhost:9411/zipkin/)

## 3. Rack up the app
```bash
rackup
```
```bash
curl http://localhost:9292
```

## 4. Add OpenTelemetry instrumentation to the app (RackUp)
```ruby
require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
# require 'opentelemetry/instrumentation/all'
require 'opentelemetry/instrumentation/rack'

ENV['OTEL_TRACES_EXPORTER'] = 'console'
OpenTelemetry::SDK.configure do |c|
  c.use 'OpenTelemetry::Instrumentation::Rack'
end
```
