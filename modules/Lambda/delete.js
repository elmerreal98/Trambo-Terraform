// Load the AWS SDK for Node.js
var AWS = require('aws-sdk');
const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context) => {
    let statusCode = '200';
    const headers = {
        'Content-Type': 'application/json',
    };

    const table = process.env.table;
    const nombre = JSON.parse(event.body).nombre;

    var params = {
        TableName: table,
        Key: {
            'Nombre': nombre
        },
        ReturnValues:"ALL_OLD"
    };
    let body = "";
    await dynamo.delete(params).promise().then(function(data) {
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
