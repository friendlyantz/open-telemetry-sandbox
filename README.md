# Prerequisits
- Docker(or Colima as a free alternative to run docker command)
- Docker Hub account

# Steps
1. `docker login`
1. Start Tracing backend (i.e. Zipkin)
```bash
docker run --rm -d -p 9411:9411 --name zipkin openzipkin/zipkin
```