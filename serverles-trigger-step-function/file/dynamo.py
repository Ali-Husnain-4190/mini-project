import json
import boto3
client = boto3.client('dynamodb')


def lambda_handler(event, context):
    print(event)
    TABLE_NAME = 'EC2TF'
    instance_id = event['instance']
    bool = event['bool']
    print(instance_id)
    print(TABLE_NAME)

    response = client.put_item(
        TableName='ec2',
        Item={
            "instance": {'S': "asdasd"},
            "id": {"S": "12"}

        }

    )
    return {
        'bool': bool
    }
