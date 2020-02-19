set -v

AWS_REGIONS=(
    ap-northeast-1
    ap-northeast-2
    ap-south-1
    ap-southeast-1
    ap-southeast-2
    ca-central-1
    eu-central-1
    eu-north-1
    eu-west-1
    eu-west-2
    eu-west-3
    sa-east-1
    us-east-1
    us-east-2
    us-west-1
    us-west-2
)


for AWS_REGION in "${AWS_REGIONS[@]}"; do

    echo "Publishing layer to region ${AWS_REGION}"
    aws lambda publish-layer-version \
        --layer-name  "pydantic" \
        --description "pydantic library for everyone!" \
        --compatible-runtimes  "python3.6" "python3.7" "python3.8" \
        --license-info "MIT" \
        --zip-file "fileb://layer.zip" \
        --region ${AWS_REGION} | tee layer.json

    LAYER_VERSION=$(jq -r '.Version' layer.json)
    echo "Updating permissions for version ${LAYER_VERSION}"
    aws lambda add-layer-version-permission \
        --layer-name "pydantic" \
        --statement-id make_public \
        --version-number ${LAYER_VERSION} \
        --principal '*' \
        --action lambda:GetLayerVersion \
        --region ${AWS_REGION} | tee layer.json

done

