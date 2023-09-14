call 7z a ..\build\function.zip ..\src\backend\index.js
call aws s3 cp ..\build\function.zip s3://filcel-deployments/function.zip
call aws cloudformation update-stack --stack-name filcel-stack-dev --template-body file://../src/backend/template.yml --parameters ParameterKey=Environment,ParameterValue=dev