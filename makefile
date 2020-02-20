.PHONY: docker clean layer all

IMAGE="lambci/lambda:build-python3.8"

layer: docker
	docker exec lambda make zip

docker:
	docker run --rm -td --name lambda -v $(shell pwd):/var/task $(IMAGE) bash

clean:
	rm -rf layer
	rm -fv test.py
	rm -fv layer.zip
	rm -fv layer.json
	docker kill lambda

zip:
	mkdir -v /tmp/python
	pip install pydantic -t /tmp/python --compile
	cd /tmp && zip -qr /var/task/layer.zip python

test:
	echo "from pydantic import BaseModel" > test.py
	echo "def handler(e, c): print(e)" >> test.py
	unzip -q layer.zip -d layer

	docker run \
		--rm \
		-v $(shell pwd):/var/task:ro,delegated \
		-v $(shell pwd)/layer:/opt:ro,delegated \
		lambci/lambda:python3.8 test.handler '{"some": "data"}'

	docker run \
		--rm \
		-v $(shell pwd):/var/task:ro,delegated \
		-v $(shell pwd)/layer:/opt:ro,delegated \
		lambci/lambda:python3.7 test.handler '{"some": "data"}'

	docker run \
		--rm \
		-v $(shell pwd):/var/task:ro,delegated \
		-v $(shell pwd)/layer:/opt:ro,delegated \
		lambci/lambda:python3.6 test.handler '{"some": "data"}'
