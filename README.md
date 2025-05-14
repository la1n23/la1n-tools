# Init script for HTB pwnbox
#### add to `~/my_data/user_init`
```bash
#!/bin/bash
cd ~/ && git clone https://github.com/la1n23/la1n-tools.git && bash la1n-tools/init.sh
```
#### or
```bash
cd ~/ && git clone https://github.com/la1n23/la1n-tools.git && bash la1n-tools/init.sh
```
#### or
```bash
curl -sSL https://raw.githubusercontent.com/la1n23/tools/refs/heads/master/init.sh|bash
```

# vim formatters for c/php/perl/json/sql
```bash
curl -sSL https://raw.githubusercontent.com/la1n23/tools/refs/heads/master/vim-autoformat.sh|bash
```
# Obsidian plugins:
* Folder notes
* Painter
* git
* Task Marker
* Templater
* Regex Find/Replace
* Canvas Mindmap
* Excalidraw

# Postman
Certs for proxy
```bash
ls ~/.config/Postman/proxy
certificates  postman-proxy-ca.crt  postman-proxy-ca.key
```

# Burpsuite configuration

### Setting up CA
Visit http://burp and click to the upper right corner to download CA

### Extensions:
#### Must have
* Logger++ for exporting history as HAR file
* https://github.com/yeswehack/PwnFox/
* JWT Editor
* InQL - graphql helper
* Hackvertor - tag-based encoder
* HTTP Request smuggler
* JS Link Finder
#### Misc
* Turbo intruder
* copy request as ffuf
* Content Type Converter
* Pram Miner (RMB -> Guess Headres - find unkeyd cache header)
* Collaborator Everywhere
* https://github.com/C-960/HTTP-Request-Converter - copy as fetch
* get all urls (GAU analogue)

### Bambdas
```
return requestResponse.httpService().host().matches("([\\.|\\w])*genius\\.com");
```

**Download Jython88**
https://repo1.maven.org/maven2/org/python/jython-standalone/2.7.4/jython-standalone-2.7.4.jar

**Cracked**
https://www.dr-farfar.com/burp-suite-professional-full/
