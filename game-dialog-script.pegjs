gameDialogScript
  = node*

node
  = dialog / cmdNode / jsExpression

dialog
  = (! (expOpen / cmdOpen) .)+ {
    const trimmedText = text().trim();

    if (trimmedText === "") {
      return null;
    }

    return {
      type: "dialog",
      text: trimmedText
    };
  }

// # Command Definition Section

cmdNode "command node"
  = cmd:(ifCmdBlock / eachCmdBlock) {
    return {
      type: "command",
      ...cmd
    };
  }

customCmd "custom command"
  = cmdOpen cmdType:$[a-zA-Z]+ param:cmdParam? cmdClose {
    return {
      cmdType,
      param
    };
  }

// ## Command Definition Utility Rules

cmdOpen "command open"
  = "{{#"

cmdClose "command close"
  = "}}"

cmdParamJS "command param JS"
  = $(jsBlock / jsString / (! cmdClose .))+

cmdParam "command param"
  = _ js:cmdParamJS { return js }

// ## If Command Definition

ifCmdBlock "if command block"
  = ifCmd:ifCmd ifBlock:ifNode* elseChain:elseBlockLink* endIfCmd {
    const chain = [
      { condition: ifCmd.param, block: ifBlock },
      ...elseChain
    ];

    return {
      cmdType: "ifBlock",
      chain
    };
  }

elseBlockLink "else block link"
  = elseCmd:elseCmd block:ifNode* {
    return {
      condition: elseCmd.param,
      block
    };
  }

ifNode "if node"
  = ! (endIfCmd / elseCmd) node:node { return node }

ifCmd "if command"
  = cmdOpen "if" param:cmdParam cmdClose {
    return {
      cmdType: "if",
      param
    };
  }

elseCmd "else command"
  = cmdOpen "else" param:cmdParam? cmdClose {
    return {
      cmdType: "else",
      param
    };
  }

endIfCmd "end if command"
  = cmdOpen "endIf" cmdClose {
    return { cmdType: "endIf" };
  }

// ## Each Loop Command Definition

eachCmdBlock "each command block"
  = eachCmd:eachCmd block:eachNode* endEachCmd {

    return {
      cmdType: "eachBlock",
      param: eachCmd.param,
      block
    };
  }

eachNode "each node"
  = ! endEachCmd node:node { return node }

eachCmd "each command"
  = cmdOpen "each" param:cmdParam cmdClose {
    return {
      cmdType: "each",
      param
    };
  }

endEachCmd "end each command"
  = cmdOpen "endEach" cmdClose {
    return { cmdType: "endEach" };
  }

// # JS Expression Definition

jsExpression
  = expOpen js:js expClose {
    return {
      type: "jsExpression",
      js: js.trim()
    };
  }

expOpen "expression open"
  = "{{"

expClose "expression close"
  = "}}"

js
  = $(jsBlock / jsString / (! expClose .))+

jsBlock
  = jsBlockOpen jsBlockContent jsBlockClose

jsBlockContent
  = (jsBlock / jsString / (! jsBlockClose .))*

jsBlockOpen
  = "{"

jsBlockClose
  = "}"

jsString
  = jsSingleQuoteString / jsDoubleQuoteString / jsBacktickQuoteString

jsSingleQuoteString
  = sq ("\\\\" / "\\'" / (! sq .))* sq

jsDoubleQuoteString
  = dq ("\\\\" / "\\\"" / (! dq .))* dq

jsBacktickQuoteString
  = bq ("\\\\" / "\\`" / "\\${" / jsBacktickInterpolation / (! bq .))* bq

jsBacktickInterpolation
  = "${" jsBlockContent "}"

// # Global Utility Rules

sq "single quote"
  = "'"

dq "double quote"
  = "\""

bq "backtick quote"
  = "`"

_ "whitespace"
  = [ \t\n\r]
