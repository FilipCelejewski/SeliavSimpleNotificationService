param ($environment)

$BuildDirectoryName = "build"
$StackName = "filcel-stack-$environment"

Write-Host "Creating build directory"
if (Test-Path $BuildDirectoryName) {
    Remove-Item $BuildDirectoryName -Force -Recurse
}
New-Item -ItemType Directory -Name $BuildDirectoryName

Write-Host "Compressing notification function code"
Compress-Archive -Path src\backend\index.js -DestinationPath $BuildDirectoryName\function.zip

Write-Host "Uploading notification function zip to S3 bucket"
aws s3 cp $BuildDirectoryName\function.zip s3://filcel-deployments/function.zip

aws cloudformation deploy --stack-name $StackName --template-file src/backend/template.yml --parameter-overrides Environment=$environment --capabilities CAPABILITY_NAMED_IAM --no-fail-on-empty-changeset

