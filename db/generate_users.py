import csv
import random
from random_username.generate import generate_username
print("Input # of users you want to generate")
val = int(input())
names = generate_username(val)
data = {}
import csv

with open('data/users.csv', mode='w') as user_file:
    user_writer = csv.writer(user_file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    user_writer.writerow(['Name', 'Cash_Balance'])
    for i in range(val):
        user_writer.writerow([names[i], 'password', random.randint(1000, 100000)])
    
    