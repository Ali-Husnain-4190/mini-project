animal = {
    'a': 'animal',
    'b': 'bear',
    'c': 'car'
}
# animal['d'] = 'dog'
# print(animal['d'])
# animal['a'] = 'apple'
# # print(animal)

# print(animal.keys())
# print(animal.values())
# listOfValue = list(animal.values())
# print(listOfValue)

# animal.get('e', 'elephent')
myfamily = {
    "child1": [
        "Emil",
        2004
    ],
    "child2": [
        "Tobias", 2007
    ]
}
myfamily['child1'].append('b')

print(myfamily)


# Remove Item from dic

# myfamily.pop('child2')
# print(myfamily)

# Print key of dict
thisdict = {
    "brand": "Ford",
    "model": "Mustang",
    "year": 1964
}

# for x in thisdict:
#     print(x)

# for x in thisdict:
#     print(thisdict[x])


for x in thisdict.values():
    print(x)


Set up a new CloudTrail trail in
a new S3 bucket using the AWS CLI and also pass
both the - - is -multi-region-trail

and --include-global -service-events parameters then encrypt log files using KMS
encryption. Apply Multi Factor Authentication(MFA)
Delete on the S3 bucket and ensure
that only authorized users can access the logs by configuring the bucket policies.
