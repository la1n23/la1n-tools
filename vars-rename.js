/* 
  npm init
  npm install @babel/parser @babel/traverse @babel/generator
*/
const parser = require("@babel/parser");
const traverse = require("@babel/traverse").default;
const generator = require("@babel/generator").default;
const fs = require("fs");
const path = require("path");

const inputFile = process.argv[2];
if (!inputFile) {
    console.error("Please provide an input file.");
    process.exit(1);
}

const outputFile = inputFile.replace(/\.js$/, ".vars.js");

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

console.log(`Processing complete. Output written to: ${outputFile}`);

