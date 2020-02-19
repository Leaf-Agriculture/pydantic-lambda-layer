.PHONY: docker clean layer all

IMAGE="lambci/lambda:build-python3.8"

layer: docker
	docker exec lambda make zip

docker:
	docker run --rm -td --name lambda -v $(shell pwd):/var/task $(IMAGE) bash

clean:
	rm -fv layer.zip
	docker kill lambda

zip:
	mkdir -v /tmp/python
	pip install pydantic -t /tmp/python --compile
	cd /tmp && zip -r /var/task/layer.zip python

deploy:
	aws lambda publish-layer-version \
		--layer-name  "test123123132" \
		--description "pydantic library for everyone!" \
		--compatible-runtimes  "python3.6" "python3.7" "python3.8" \
		--license-info "MIT" \
		--zip-file "fileb://layer.zip"

