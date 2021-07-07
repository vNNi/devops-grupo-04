import boto3
import json
import os

def handler(event, context):
    payload = json.loads(event.get('body'))
    
    # send to SNS
    sns = boto3.client('sns')
    snsArn=os.environ.get('snsArn', '')

    res = sns.publish(
                    TopicArn=snsArn,
                    Subject="Order Creation",
                    Message=json.dumps(payload),
                    )

    message={"Status":"Created","BookID": payload.get('book_id')}
    
    response = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(message)
    }

    return response
