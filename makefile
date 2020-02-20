.PHONY: docker clean layer all

IMAGE="lambci/lambda:build-python3.8"

layer: docker
	docker exec lambda make zip

docker:
	docker run --rm -td --name lambda -v $(shell pwd):/var/task $(IMAGE) bash

clean:
	rm -fv layer.zip
	rm -fv layer.json
	docker kill lambda

zip:
	mkdir -v /tmp/python
	pip install pydantic -t /tmp/python --compile
	cd /tmp && zip -qr /var/task/layer.zip python

