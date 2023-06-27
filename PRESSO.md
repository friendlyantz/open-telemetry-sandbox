
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



## A bit of Observability theory and why I decided to do this talk

- [ ] As a TDD fanboy, and a person who watch too much of David Farley, I was surprised to discover that TikTok doesn't use tests ? 

Observability lets us understand a system from the outside, by letting us ask questions about that system without knowing its inner workings. Furthermore, it allows us to easily troubleshoot and handle novel problems (i.e. “unknown unknowns”), and helps us answer the question, “Why is this happening?”

In order to be able to ask those questions of a system, the application must be properly instrumented. That is, the application code must emit signals such as traces, metrics, and logs. An application is properly instrumented when developers don’t need to add more instrumentation to troubleshoot an issue, because they have all of the information they need.

OpenTelemetry is the mechanism by which application code is instrumented, to help make a system observable.

---

### Understanding Distributed Tracing
- [ ] Tender Driven Development

---

spans

![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/6434babf-bd37-4f35-8a1b-45e6b74090c5)

---

# What is Telemetry Theory

OpenTelemetry is:
 - a collection of tools, APIs, and SDKs. 
 - Use it to instrument, generate, collect, and export telemetry data (metrics, logs, and traces) to help you analyze your software’s performance and behavior

 - open-source, vendor agnostic
 - merger of openCensus and openTracing project
 - It is part on [CNCF](https://www.cncf.io/projects/opentelemetry/) since 2019 and 2nd most active project after Kubernetes. 
 - a lot of high-cal contributors

It is extensible framework which supports [multiple languages ](https://opentelemetry.io/docs/instrumentation/#status-and-releases)and open-source data standard like you see in Prometheus, Jaeger as well as commercial vendors like DataDog, Splunk, etc

---




---

## OpenTelemetry [Components](https://opentelemetry.io/docs/concepts/components/) - very confusing and constantly evolving, but bare with meh
1. [Specification](https://opentelemetry.io/docs/concepts/components/#specification) basic for the below items, outlines requirements
2. [Collector](https://opentelemetry.io/docs/concepts/components/#collector)
3. [Language-specific Instrumentation, API & SDK implementations](https://opentelemetry.io/docs/concepts/components/#language-specific-api--sdk-)
4. etc. 

---

##  [Specification](https://opentelemetry.io/docs/concepts/components/#specification) 

Describes the cross-language requirements and expectations for all implementations. Beyond a definition of terms, the specification defines the following:

- **API:** Defines data types and operations for generating and correlating tracing, metrics, and logging data.
- **SDK:** Defines requirements for a language-specific implementation of the API. Configuration, data processing, and exporting concepts are also defined here.
- **Data:** Defines the OpenTelemetry Protocol (OTLP) and vendor-agnostic [semantic conventions](https://opentelemetry.io/docs/concepts/semantic-conventions/) that a telemetry backend can provide support for.

#### Why you need this?? 
- so if you adhere to this spec you can built more comprehensive insights and get some insights into other endpoints or closed source services that are compatible with OT standard (and most are)
- you have Data portability and quickly change vendors

---

## [Instrumentation, Language-specific API & SDK implementations](https://opentelemetry.io/docs/concepts/components/#language-specific-api--sdk-implementations)

OpenTelemetry also has language SDKs that let you use the OpenTelemetry API to generate telemetry data with your language of choice and export that data to a preferred backend. These SDKs also let you incorporate instrumentation libraries for common libraries and frameworks that you can use to connect to manual instrumentation in your application.

[Ruby Instrumentation Repo](https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/instrumentation)

---


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

---

### Resources:
1. https://opentelemetry.io/
2. https://www.jaegertracing.io/ - backend for above (optional, you can use your own existing compatible provider, i.e DataDog, Splunk, etc)
3. https://youtu.be/Txe4ji4EDUA - fantastic tutorial by NGNIX, which inspired this talk
4. https://github.com/open-telemetry/opentelemetry-demo
