Write-Host "Creating build directory"
New-Item -ItemType Directory -Path "." -Name "build"

Write-Host "Compressing notification function code"
Compress-Archive -Path ..\src\backend\index.js -DestinationPath ..\build\function.zip 

Write-Host "Uploading notification function zip to S3 bucket"

Write-Host "Creating stack using CloudFormation"