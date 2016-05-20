IMAGE ?= agalitsyn/goci:1.6
REGISTRY ?=

build:
	docker build --pull --rm -t "$(IMAGE)" .

push:
	docker push "$(IMAGE)"

push-private:
	docker tag "$(IMAGE)" "$(REGISTRY)/$(IMAGE)"
	docker push "$(REGISTRY)/$(IMAGE)"
