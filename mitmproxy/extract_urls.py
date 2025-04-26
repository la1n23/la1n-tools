"""
mitmdump -q -nr flows -s extract_urls.py 2>/dev/null
"""
def response(flow):
    print(flow.request.pretty_url)
