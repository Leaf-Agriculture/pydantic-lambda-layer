# Pydantic AWS Lambda layer
A lambda layer with Pydantic for all to use. License is MIT.

[![Build Status](https://travis-ci.com/Leaf-Agriculture/pydantic-lambda-layer.svg?branch=master)](https://travis-ci.com/Leaf-Agriculture/pydantic-lambda-layer)

## Version
**Pydantic 1.4**

The version is not strictly defined. Is the one in PIP when a merge to `master` was performed.

## Creation
To create the package we use the docker images provided by the gods, [Lambci](https://github.com/lambci/). We build this layer using `lambci/lambda:build-python3.8` image.

## Deploy
The deployment is fully automatic, performed by travis. We create the layer package using a `makefile` and deploy it to every region in AWS using a custom, but simple, bash script.

## ARNs
Here is the full list of ARNs of the lambdas.

```
arn:aws:lambda:ap-northeast-1:558258168256:layer:pydantic:1
arn:aws:lambda:ap-northeast-2:558258168256:layer:pydantic:1
arn:aws:lambda:ap-south-1:558258168256:layer:pydantic:1
arn:aws:lambda:ap-southeast-1:558258168256:layer:pydantic:1
arn:aws:lambda:ap-southeast-2:558258168256:layer:pydantic:1
arn:aws:lambda:ca-central-1:558258168256:layer:pydantic:1
arn:aws:lambda:eu-central-1:558258168256:layer:pydantic:1
arn:aws:lambda:eu-north-1:558258168256:layer:pydantic:1
arn:aws:lambda:eu-west-1:558258168256:layer:pydantic:1
arn:aws:lambda:eu-west-2:558258168256:layer:pydantic:1
arn:aws:lambda:eu-west-3:558258168256:layer:pydantic:1
arn:aws:lambda:sa-east-1:558258168256:layer:pydantic:1
arn:aws:lambda:us-east-1:558258168256:layer:pydantic:1
arn:aws:lambda:us-east-2:558258168256:layer:pydantic:1
arn:aws:lambda:us-west-1:558258168256:layer:pydantic:1
arn:aws:lambda:us-west-2:558258168256:layer:pydantic:1
```
