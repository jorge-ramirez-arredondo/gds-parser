const fs = require("fs");

// Extend require to support pegjs files as text
require.extensions['.pegjs'] = function (module, filename) {
    module.exports = fs.readFileSync(filename, 'utf8');
};

const gameDialogScript = [
	require("./GameDialogScript.pegjs"),
	require("./Command.pegjs"),
	require("./PauseCommand.pegjs"),
	require("./IfCommand.pegjs"),
	require("./EachCommand.pegjs"),
	require("./JSExpression.pegjs"),
	require("./Utilities.pegjs")
];

module.exports = gameDialogScript.join("\n");
