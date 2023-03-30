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
