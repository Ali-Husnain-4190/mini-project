import boto3
from botocore.exceptions import ClientError


def lambda_handler(event, context):

    regions = [
        # #'ap-east-1',
        # 'ap-northeast-1',
        # 'ap-northeast-2',
        # 'ap-south-1',
        # 'ap-southeast-1',
        # 'ap-southeast-2',
        # 'ca-central-1',
        # 'eu-central-1',
        # 'eu-north-1',
        # 'eu-west-1',
        # 'eu-west-2',
        # 'eu-west-3',
        # #'me-south-1',
        'sa-east-1',
        'us-east-1',
        'us-east-2',
        'us-west-1',
        'us-west-2'
    ]
    for region_name in regions:
        print(f'region_name: {region_name}')
        ec2 = boto3.resource('ec2', region_name=region_name)

        instances = ec2.instances.filter(
            Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

        for instance in instances:
            #print(instance.id, instance.instance_type)
            instance.stop()
            print('stopped instance is :', instance.id)
