$BuildDirectoryName = "build"

Write-Host "Creating build directory"
if (Test-Path $BuildDirectoryName) {
    Remove-Item $BuildDirectoryName -Force -Recurse
}
New-Item -ItemType Directory -Name $BuildDirectoryName

Write-Host "Compressing notification function code"
Compress-Archive -Path src\backend\index.js -DestinationPath $BuildDirectoryName\function.zip

Write-Host "Uploading notification function zip to S3 bucket"

Write-Host "Creating stack using CloudFormation"