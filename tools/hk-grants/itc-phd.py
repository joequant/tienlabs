#!/usr/bin/python3

"""
script for getting CSV list of phd grants
"""

import requests
import urllib.request
import time
from bs4 import BeautifulSoup
import re

def dump_grants(t):
    doc = BeautifulSoup(t, 'html.parser')
    prjRef = [x.a.contents[0] for x in doc.find_all(class_='tdPrjRef')]
    prjTitle = [x.a.contents[0] for x in doc.find_all(class_='tdPrjTitle')]
    prjAmount = [x.contents[0] for x in doc.find_all(class_='tdPrjAmount')]
    prjPC = [x.a.contents[0] for x in doc.find_all(class_='prjSearchPC')]
    prjOrg = [x.a.contents[0] for x in doc.find_all(class_='prjSearchOrg')]
    return zip(prjRef,
               prjTitle,
               prjAmount,
               prjPC,
               prjOrg)

s = requests.Session()

def get_token():
    r = s.get('https://www.itf.gov.hk/l-eng/Prj_Search.asp?code=101')
    doc = BeautifulSoup(r.text, 'html.parser')
    return doc.find(id='tbl_prj_search').find('input', {'name': 'token'})['value']

t = get_token()
print(t)
r = s.post("https://www.itf.gov.hk/l-eng/Prj_SearchResult.asp", {
    "prj_prog": "PhD",
    "token" : t
    })

#doc = BeautifulSoup(r.text, 'html.parser')
#h = [x.find('a')['href'] for x in doc.find_all('td', {'class':'tdPrjRef'})]
#print(h)

m = re.search('Page 1 of ([0-9]+)', r.text)
npages = int(m.group(1))
g = dump_grants(r.text)
print("# page 1 of %d" % npages)
for i in g:
    print(",".join(i))

for p in range(2, npages+1):
    grants = True
    while grants:
        r = s.post("https://www.itf.gov.hk/l-eng/Prj_SearchResult.asp", {
            "prj_prog": "PhD",
            "token" : t,
            "page_no" : p
            })
        print("# page %d of %d" % (p, npages))
        g = dump_grants(r.text)
        for i in g:
            print(",".join(i))
            grants = False
        if grants:
            t = get_token()

