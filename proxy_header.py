from mitmproxy import http

"""
pip install mitmproxy

mitmproxy -s proxy_header.py --mode regular -p 6666

"""
def request(flow: http.HTTPFlow) -> None:
    flow.request.headers["X-BugBounty"] = "07db4c22-66e8-4387-9fe9-958345d5bfXX"
