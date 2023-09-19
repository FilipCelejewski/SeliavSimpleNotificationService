$BuildDirectoryName = "build"

Write-Host "Creating build directory"
if (Test-Path $BuildDirectoryName) {
    Remove-Item $BuildDirectoryName -Force -Recurse
}
New-Item -ItemType Directory -Name $BuildDirectoryName

Write-Host "Compressing notification function code"
Compress-Archive -Path src\backend\index.js -DestinationPath $BuildDirectoryName\function.zip

Write-Host "Uploading notification function zip to S3 bucket"
aws s3 cp $BuildDirectoryName\function.zip s3://filcel-deployments/function.zip

aws cloudformation describe-stacks --stack-name filcel-stack-dev
Write-Host $LASTEXITCODE

if ($LASTEXITCODE -eq 0)
{
    Write-Host "Updating stack using CloudFormation"
    aws cloudformation update-stack --stack-name filcel-stack-dev --template-body file://src/backend/template.yml --parameters ParameterKey=Environment,ParameterValue=dev --capabilities CAPABILITY_NAMED_IAM
} else {
    Write-Host "Creating stack using CloudFormation"
    aws cloudformation create-stack --stack-name filcel-stack-dev --template-body file://src/backend/template.yml --parameters ParameterKey=Environment,ParameterValue=dev --capabilities CAPABILITY_NAMED_IAM
}