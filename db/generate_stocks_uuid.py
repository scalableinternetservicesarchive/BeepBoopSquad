import csv
import random

import uuid
print("Input # of stocks you want to generate")
val = int(input())
names = []
for i in range(val):
    names.append(str(i))
length = len(names)
print("Input ID of csv file (index starting at 0")
val = input()
if len(val) == 0:
    val = ""
data = {}
import csv

with open('data/stocks{0}.csv'.format(val), mode='w') as user_file:
    user_writer = csv.writer(user_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    user_writer.writerow(['Symbol', 'Name', 'Share_Price'])
    for i in range(length):
        user_writer.writerow([names[i], names[i], random.randint(10, 1000)])
    
    