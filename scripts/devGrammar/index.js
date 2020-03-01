const peg = require("pegjs");
const fs = require("fs");

const gdsGrammar = require("../../gdsGrammar");

const gdsParser = peg.generate(gdsGrammar);

const testGDS = fs.readFileSync(`${__dirname}/test.gds`, 'utf8');

const ast = gdsParser.parse(testGDS);

console.log('\033[2J'); // Clear console
console.log(JSON.stringify(ast, null, 2));
