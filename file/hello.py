def lambda_handler(event, context):
    ec2_instance_id = event['detail']['instance-id']

    print(ec2_instance_id)
    bool = True
    if ec2_instance_id == '':
        bool = False

    print(bool)
    return {

        'instance': ec2_instance_id,
        'bool': bool

    }
