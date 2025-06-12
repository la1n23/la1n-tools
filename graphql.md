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

## introspection to schema
```bash
npx graphql-introspection-json-to-sdl ./schema-2022-with-10k-fields.gql > 2022.sdl
```

## compare two introspections
```bash
bun add --global @graphql-inspector/cli graphql
graphql-inspector diff ./schema-2022-with-10k-fields.gql ./schema-2024-with-10k-fields.gql
```

## compare two sdl
```bash
gem install graphql-schema_comparator
schema_comparator compare ./2024.sdl ./final_scheme.sdl
```
