
# Intro 

 1. what this talk is about and why you might be interested 
- [ ] Intro
- [ ] Open Telemetry Theory
	- [ ] History
- [ ] Demo
	- [ ] Basic vanilla Ruby
	- [ ] Ruby with multiple gems
	- [ ] Multi-language
---

## About me
```ruby
class Friendlyantz
  def initialize
    @name = 'Anton Panteleev'
    @dob = '1987-04-01T04:15:00'
    @title = 'Engineer, Software Stuntman aspiring Dev Advocate'
   @hobbies = [ 'Kitesurfing', 
                 'Camping',
                 'Art Photography',
                 'Motorcycling',
                 'Longboarding' ]
  end

  def current_location
    'Melbourne, Australia'
  end
  ```
https://friendlyantz.me/

---

# What is Telemetry Theory

OpenTelemetry is:
 - a collection of tools, APIs, and SDKs. 
 - Use it to instrument, generate, collect, and export telemetry data (metrics, logs, and traces) to help you analyze your software’s performance and behavior
 
 - in an open-source, vendor agnostic way
 - It is part on [CNCF](https://www.cncf.io/projects/opentelemetry/) since 2019 and 2nd most active project after Kubernetes. Also a lot of high-cal contributors

It is extensible framework which supports [multiple languages ](https://opentelemetry.io/docs/instrumentation/#status-and-releases)and open-source data standard like you see in Prometheus, Jaeger as well as commercial vendors like DataDog, Splunk, etc

---

![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/e63bbdec-455f-4609-a2a5-9ab04fc37e78)

---

spans

![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/6434babf-bd37-4f35-8a1b-45e6b74090c5)

---

OT [Components](https://opentelemetry.io/docs/concepts/components/)
### Specification

---

### Basic:

---

Complex 





---


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



---

# Summary

---

### Resources:
1. https://opentelemetry.io/
2. https://www.jaegertracing.io/ - backend for above (optional, you can use your own existing compatible provider, i.e DataDog, Splunk, etc)
3. https://youtu.be/Txe4ji4EDUA - fantastic tutorial by NGNIX, which inspired this talk
4. https://github.com/open-telemetry/opentelemetry-demo
