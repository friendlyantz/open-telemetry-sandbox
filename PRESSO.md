
## Action Plan

- Part I
	1. Observabitiy
	2. "Open Telemetry" OS project
	3. It's components
- Part II - Demo:
	1. Basic implementation with vanilla Ruby
	2. Ruby with multiple gems

---

## About me
```ruby
class Friendlyantz
  def initialize
    @name = 'Anton Panteleev'
    @dob = '1987-04-01T04:15:00'
    @title = 'Engineer, Software Stuntman and aspiring Dev Advocate, Saul Goodman of Tech'
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

## Observability

A bit of theory and why I decided to do this talk


---

### Distributed Tracing
- [ ] Signals are not very useful when they are isolated
- [ ] Tender Driven Development
- [ ] Context Propagation

---

Spans

![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/6434babf-bd37-4f35-8a1b-45e6b74090c5)

---

## OpenTelemetry 

OpenTelemetry is:
 - a collection of tools, APIs, and SDKs. 
 - Use it to instrument, generate, collect, and export telemetry data (metrics, logs, and traces) to help you analyze your software’s performance and behavior


---

 - It started as a merger of OpenCensus and openTracing 
 - open-source, vendor agnostic
 - It is part on [CNCF](https://www.cncf.io/projects/opentelemetry/) since 2019 and 2nd most active project after Kubernetes.
 - [many popular languages are supported](https://opentelemetry.io/docs/instrumentation/#status-and-releases)
 - a lot of high-calibre contributors (GitHub, Shopify, Google, etc)

---

## OpenTelemetry [Components](https://opentelemetry.io/docs/concepts/components/) 
A bit confusing and constantly evolving, but some of the basic concepts are:

![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/8f9c3e48-ee8b-4094-aeb1-d812a51afb4d)

- [Specification](https://opentelemetry.io/docs/concepts/components/#specification) 
- Implementations
	1. [Language-specific Instrumentation, API & SDK implementations](https://opentelemetry.io/docs/concepts/components/#language-specific-api--sdk-implementations)
	2. [Collector](https://opentelemetry.io/docs/concepts/components/#collector) - like an agent / service that marries different telemetry streams

---

##  [Specification](https://opentelemetry.io/docs/concepts/components/#specification) 

- Semantic Convention
- Resources

---

## [Instrumentation, Language-specific API & SDK implementations](https://opentelemetry.io/docs/concepts/components/#language-specific-api--sdk-implementations)

i.e. [Ruby Instrumentation Repo](https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/instrumentation)

---

## Collector
![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/a0397a17-041a-4a1d-acb1-f98f35c18d49)

---

# Demo

---

### Basic:

---

## Complex  


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
- [ ] challenge Anton to match a talk
---

### Resources:
1. https://opentelemetry.io/
2. https://www.jaegertracing.io/ - backend for above (optional, you can use your own existing compatible provider, i.e DataDog, Splunk, etc)
3. https://youtu.be/Txe4ji4EDUA - fantastic tutorial by NGNIX, which inspired this talk
4. https://github.com/open-telemetry/opentelemetry-demo
