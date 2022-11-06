import csv
import sys
from collections import OrderedDict
maxInt = sys.maxsize

while True:
    # decrease the maxInt value by factor 10 
    # as long as the OverflowError occurs.

    try:
        csv.field_size_limit(maxInt)
        break
    except OverflowError:
        maxInt = int(maxInt/10)

def fix_nulls(s):
    for line in s:
        yield line.replace('\0',' ')

def read_csv(filepath):
    data = []
    with open(filepath,mode="r",encoding='utf-8') as file:
        csvfile = csv.reader(fix_nulls(file))
        for row in csvfile:
            data.append(row)
    return data

# sort a dictionary by value

def sort_dict_by_value(d):
    return OrderedDict(sorted(d.items(), key=lambda x: x[1], reverse=True))
