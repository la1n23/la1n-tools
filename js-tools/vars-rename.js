#!/usr/bin/env node

const parser = require("@babel/parser");
const traverse = require("@babel/traverse").default;
const generator = require("@babel/generator").default;
const fs = require("fs");
const path = require("path");


if (process.argv.length <= 2) {
  console.error("npx ~/la1n-tools/js-tools/ [file1] [file2]...");

  process.exit(1);
}
const fileNames = process.argv.slice(2)

for (const inputFile of fileNames) {
  if (inputFile.includes(".vars.js")) {
      console.error(`${inputFile} ignored`);
      continue;
  }

  const outputFile = inputFile.replace(/\.js$/, ".vars.js");
  if (fs.existsSync(outputFile)) {
      console.error(`${inputFile} ignored because ${outputFile} already exist`);
      continue;
  }

  console.log(`${inputFile} processing...`);
  const code = fs.readFileSync(inputFile, "utf-8");

  const ast = parser.parse(code, {
      sourceType: "unambiguous",
      allowReturnOutsideFunction: true,
      allowAwaitOutsideFunction: true,
      errorRecovery: true,
      plugins: [
          "jsx",
          "classProperties",
          "dynamicImport",
          "optionalChaining",
          "nullishCoalescingOperator",
          "objectRestSpread"
      ]
  });

  let counter = 0;

  function generateName() {
      counter++;
      return `__var_${String(counter).padStart(5, '0')}__`;
  }

  traverse(ast, {
      Scopable(path) {
          const bindings = path.scope.getAllBindings();

          for (const name in bindings) {
              if (name.length <= 2) {
                  const binding = bindings[name];
                  const newName = generateName();
                  binding.scope.rename(name, newName);
              }
          }
      }
  });

  const output = generator(ast, { compact: false }).code;
  fs.writeFileSync(outputFile, output);

  console.log(`${inputFile} completed`);
}
