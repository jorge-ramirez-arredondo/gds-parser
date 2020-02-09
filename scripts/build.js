const peg = require("pegjs");
const fs = require("fs");

const gdsGrammar = require("../gdsGrammar");

const gdsParserSource = peg.generate(
	gdsGrammar,
	{ output: "source" }
);

fs.writeFileSync(`${__dirname}/../dist/gds-parser.js`, gdsParserSource);
