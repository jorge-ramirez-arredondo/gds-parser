const peg = require("pegjs");
const fs = require("fs");

const gdsGrammar = require("../gdsGrammar");

const gdsParserSource = peg.generate(
  gdsGrammar,
  {
    output: "source",
    format: "commonjs"
  }
);

fs.writeFileSync(`${__dirname}/../dist/gds-parser.js`, gdsParserSource);
