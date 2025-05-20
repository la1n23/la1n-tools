from burp import IBurpExtender, IHttpListener
from java.io import PrintWriter

class BurpExtender(IBurpExtender, IHttpListener):

    def registerExtenderCallbacks(self, callbacks):
        self._callbacks = callbacks
        self._helpers = callbacks.getHelpers()
        self._stdout = PrintWriter(callbacks.getStdout(), True)
        callbacks.setExtensionName("Remove JWT token")
        callbacks.registerHttpListener(self)

    def processHttpMessage(self, toolFlag, messageIsRequest, messageInfo):
        if not messageIsRequest:
            return

        request = messageInfo.getRequest()
        analyzed_request = self._helpers.analyzeRequest(request)
        headers = list(analyzed_request.getHeaders())

        new_headers = []
        for header in headers:
            if header.lower().startswith("cookie:"):
                cookies = header[7:].split(";")
                filtered = [c.strip() for c in cookies if not c.strip().startswith("ud_user_jwt=")]
                if filtered:
                    new_headers.append("Cookie: " + "; ".join(filtered))
                # If no cookies left, skip the Cookie header entirely
            else:
                new_headers.append(header)

        body = request[analyzed_request.getBodyOffset():]
        new_request = self._helpers.buildHttpMessage(new_headers, body)
        messageInfo.setRequest(new_request)
