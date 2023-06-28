.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
NC      = \033[0m

.PHONY: jaeger-setup
jaeger-setup:
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

.PHONY: jaeger-web-open
jaeger-web-open:
	open http://localhost:16686

.PHONY: rack-demo
rack-demo:
	rackup --include rack_demo/lib rack_demo/config.ru

.PHONY: rack-demo-open
rack-demo-open:
	open http://127.0.0.1:9292/

.PHONY: sidekiq-web
sidekiq-web:
	bundle exec rackup multi_span/sidekiq_web_config.ru -p 9393

.PHONY: sidekiq-web-open
sidekiq-web-open:
	open http://localhost:9393

.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${NC} Welcome to ${RED}${CURRENT_DIR}${NC}"
	@echo
	@echo "${YELLOW}make${NC}                  	show this usage menu"
	@echo "${YELLOW}make jaeger-setup${NC}"
	@echo
	@echo "${YELLOW}make jaeger-web-open${NC}"
	@echo "${YELLOW}make rack-demo${NC}"
	@echo "${YELLOW}make rack-demo-open${NC}"
	@echo "${YELLOW}make sidekiq-web${NC}"
	@echo "${YELLOW}make sidekiq-web-open${NC}"
	@echo