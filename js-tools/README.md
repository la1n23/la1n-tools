# Rename minified variables to unique identifier
```bash
~/la1n-tools/js-tools/vars-rename.js *.js
```

# Extract URLs form HAR file

```bash
cat js.har | jq '.log.entries.[].request.url' | tr -d '"' > jsfiles.txt
wget --input-file ./jsfiles.txt
```

# Recover source code and print urls that have not been mapped
```bash
while IFS= read -r line; do
  npx js-source-extractor "$line" --outDir ./output_dir >/dev/null 2>&1 || echo "$line"
done < jsfiles.txt
```
