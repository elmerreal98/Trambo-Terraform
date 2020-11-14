// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context) => {
    let statusCode = '200';
    const headers = {
        'Content-Type': 'application/json',
    };
    
    const nombre = JSON.parse(event.body).nombre;
    const edad = JSON.parse(event.body).edad;
    const table = process.env.table;


    var params = {
        TableName: table,
        Key: {
            'Nombre': nombre
        },
        UpdateExpression: "set Edad = :r",
        ExpressionAttributeValues:{
            ":r":edad
        },
        ReturnValues:"UPDATED_NEW"
    };
    let body = "";
    await dynamo.update(params).promise().then(function(data) {
        body= JSON.stringify(data);
      }).catch(function(err) {
        body=JSON.stringify(err);
      });

    return {
        statusCode,
        body,
        headers,
    };
};
