"""
test lambda which does nothing
"""
def lambda_handler(event, context):
    print(event)
    print(context)
    return event, context