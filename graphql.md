# GraphQL

## Wordlist
Extract words
```bash
tr ' ' '\n' < queries.gql | grep -Pv '^[\s\W]*$' | tr '(' '\n' | tr -d '):$!,.][{}@' | grep -Pv '^\d+$' | grep -Pv '^[\s\W]*$' | grep -Pv '^\w$' | sort -u > queries.wl
```

## Split long camelcase words
```bash
cat queries.wl | perl -pe 's/(?<=[a-z])(?=[A-Z])/\n/g' >> wl.txt
cat queries.wl >> wl.txt
uu wl.txt
```

## Upcase and down case
```bash
while IFS= read -r line; do echo "$line" | awk '{print toupper(substr($0,1,1)) substr($0,2)}'; echo "$line" | awk '{print tolower(substr($0,1,1)) substr($0,2)}'; echo "$line"; done < wl.txt | sort -u
```
