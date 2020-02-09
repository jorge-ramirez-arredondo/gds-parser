// ## If Command Definition

IfCmdBlock "if command block"
  = ifCmd:IfCmd ifBlock:IfNode* elseChain:ElseBlockLink* EndIfCmd {
    const chain = [
      { condition: ifCmd.param, block: ifBlock },
      ...elseChain
    ];

    return {
      cmdType: "ifBlock",
      chain
    };
  }

ElseBlockLink "else block link"
  = elseCmd:ElseCmd block:IfNode* {
    return {
      condition: elseCmd.param,
      block
    };
  }

IfNode "if node"
  = ! (EndIfCmd / ElseCmd) node:Node { return node }

IfCmd "if command"
  = CmdOpen "if" param:CmdParam CmdClose {
    return {
      cmdType: "if",
      param
    };
  }

ElseCmd "else command"
  = CmdOpen "else" param:CmdParam? CmdClose {
    return {
      cmdType: "else",
      param
    };
  }

EndIfCmd "end if command"
  = CmdOpen "endIf" CmdClose {
    return { cmdType: "endIf" };
  }
