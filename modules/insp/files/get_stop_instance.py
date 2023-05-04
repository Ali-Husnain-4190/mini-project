import boto3
import boto3
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb', region_name='us-east-1')


def send_email(listData):

    SENDER = "EnterSendEmail@gmail.com"  # must be verified in AWS SES Email
    RECIPIENT = "RecieverEmail@gmail.com"  # must be verified in AWS SES Email

    # If necessary, replace us-west-2 with the AWS Region you're using for Amazon SES.
    AWS_REGION = "us-east-1"

    # The subject line for the email.
    SUBJECT = "Your stoped instance list!"

    # The email body for recipients with non-HTML email clients.
    BODY_TEXT = ("Hey Hi...\r\n"
                 "Take a action Below is list of stopped instance."

                 )

    # The HTML body of the email.

    BODY_HTML = f"""
    <html>
    <head></head>
    <body>

    "<h1 style="color:red;">Take a action Below is list of stopped instance.</h1>
    <p style="color:blue;">
    {
        listData
    }
        </p>
        
    </body>
    </html>
      
              """
    # The character encoding for the email.
    CHARSET = "UTF-8"
    # str= listData + BodyHTML
    # Create a new SES resource and specify a region.
    client = boto3.client('ses', region_name=AWS_REGION)

    # Try to send the email.
    try:
        # Provide the contents of the email.

        response = client.send_email(
            Destination={
                'ToAddresses': [
                    RECIPIENT,
                ],
            },
            Message={
                'Body': {
                    'Html': {

                        'Data': BODY_HTML
                    },
                    'Text': {

                        'Data': BODY_TEXT
                    },
                },
                'Subject': {

                    'Data': SUBJECT
                },
            },
            Source=SENDER
        )
    # Display an error if something goes wrong.
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("Email sent! Message ID:"),
        print(response['MessageId'])
        return True


def lambda_handler(event, context):
    bool = False
    table = dynamodb.Table('EC2TF')

    response = table.scan()
    data = response['Items']
    listData = []
    dic = {}
    count = 0
    for instance in data:
        count = count + 1
        # print(instance['instance'])
        dic = {'id': count, 'instance_id': instance['instance']}
        listData.append(dic)
    bool = send_email(listData)

    return {
        # 'stop_instance':listData
        'bool': bool
    }
