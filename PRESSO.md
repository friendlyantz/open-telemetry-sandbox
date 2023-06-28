 
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

A bit of theory and why I decided to do this talk

![observability-so-hot](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/10ef82f7-0814-46ce-a8df-851391534d51)

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

## OT [Components](https://opentelemetry.io/docs/concepts/components/) 
A bit confusing and constantly evolving, but some of the basic concepts are:

![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/8f9c3e48-ee8b-4094-aeb1-d812a51afb4d)

- [Specification](https://opentelemetry.io/docs/concepts/components/#specification) 
- Implementations
	1. [Language-specific Instrumentation, API & SDK implementations](https://opentelemetry.io/docs/concepts/components/#language-specific-api--sdk-implementations)
	2. [Collector](https://opentelemetry.io/docs/concepts/components/#collector) - like an agent / service that marries different telemetry streams

---

##  [Specification](https://opentelemetry.io/docs/concepts/components/#specification) 

- Cross-language requirements and expectations 
- API, SDK and Data Requirements
- [Semantic Convention](https://opentelemetry.io/docs/concepts/semantic-conventions/)
- [Resources](https://opentelemetry.io/docs/instrumentation/js/resources/)

---

## [Instrumentation, Language-specific API & SDK implementations](https://opentelemetry.io/docs/concepts/components/#language-specific-api--sdk-implementations)

- can be Automatic and Manual
- [Ruby Instrumentation Repo](https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/instrumentation)

---

## Collector
![image](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/a0397a17-041a-4a1d-acb1-f98f35c18d49)

---

# Demo

![listen](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/e66cc1da-5951-4747-b0d3-b61d329ff0a2)


---

### Basic Single Span:

```sh
bundle
ruby basic_single_span/basic_operation.rb
```
---

## Complex Multi Span
### Spin up 'Jaeger'
```sh
docker run -d --name jaeger \            
  -e COLLECTOR_ZIPKIN_HTTP_PORT=9411 \
  -p 5775:5775/udp \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 14268:14268 \
  -p 14250:14250 \
  -p 9411:9411 \
  jaegertracing/all-in-one
```

---

## Spin up Sidekiq in a tab
```sh
# DO NOT forget ./ in front of the required filepath)
sidekiq -r ./multi_span/job.rb

# if this doesn't work you might need to spin up redis-server if it is not running already
redis-server  
```

### Run demo script in another tab
```
ruby multi_span/complex_operations.rb 
```
and observe Sidekiq tab
 
---

### go to Jaeger UI to observe observabity observing our app 
http://localhost:16686

---

# Summary

![yes](https://github.com/friendlyantz/open-telemetry-sandbox/assets/70934030/2b19158e-55af-4cce-b4bb-d1416c9d5a11)

---

# Summary
- [ ] OT can be Automatic and Manual
- [ ] Future Adoption
- [ ] Still in active developments
- [ ] Traces are implemented, Metrics & Logs yet to come
- [ ] challenge Anton to match a talk
---

### Resources:
1. https://opentelemetry.io/
2. https://www.jaegertracing.io/ - backend for above (optional, you can use your own existing compatible provider, i.e DataDog, Splunk, etc)
3. https://youtu.be/Txe4ji4EDUA - fantastic tutorial by NGNIX, which this talk is based on
4. https://github.com/open-telemetry/opentelemetry-demo - official demo of a shopping app using various languages (mail service is in Ruby)
