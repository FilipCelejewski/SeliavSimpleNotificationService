var AWS = require("aws-sdk");

exports.handler = async function(event, context) {
    
    var sns = new AWS.SNS();

    var message = event.body.split("=")[1];
    console.log("received message: " + message);
    var params = {
        Message: message, 
        Subject: "Test SNS From Lambda",
        TopicArn: "arn:aws:sns:eu-north-1:953201351151:filcel-topic"
    };
    
    sns.publish(params, context.done);
    console.log("sent message: " + message);
 
    var response = {
        isBase64Encoded: false,
        statusCode: 200,
        
        headers: { },
        body: "sent message: " + message
    }
    
    return response;
};