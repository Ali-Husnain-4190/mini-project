import json
import boto3
from datetime import datetime
import logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)
client = boto3.client('dynamodb')


def lambda_handler(event, context):
    TABLE_NAME = 'EC2TF'
    instance_id = event['instance']
    bool = event['bool']
    print(instance_id[0])
    dateTime = datetime.now().isoformat(timespec='seconds')
    logger.info("&************Adding value into DynamoDB table")
    response = client.put_item(
        TableName=TABLE_NAME,
        Item={
            "instance": {'S': instance_id[0]},
            "id": {"S": dateTime}
        }
    )
    return {
        'bool': bool
        # 'bool': 'True'
    }
