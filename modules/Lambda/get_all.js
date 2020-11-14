var AWS = require("aws-sdk");
exports.handler = async (event, context, callback) => {

  var docClient = new AWS.DynamoDB.DocumentClient();
      
  const table = process.env.table;

  let params = { TableName: table };

  let scanResults = [];
  let items;

  do {
      items = await docClient.scan(params).promise();
      items.Items.forEach((item) => scanResults.push(item));
      params.ExclusiveStartKey = items.LastEvaluatedKey;
  } while (typeof items.LastEvaluatedKey != "undefined");

  //callback(null, scanResults);
  let statusCode = '200';
  const headers = {
      'Content-Type': 'application/json',
  };
  let body= JSON.stringify(scanResults);
  return {
       statusCode,
       body,
       headers,
   };
};