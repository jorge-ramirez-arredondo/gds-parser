// ## If Command Definition

IfCmdBlock "if command block"
  = ifCmd:IfCmd ifBlock:IfNode* elseChain:ElseBlockLink* EndIfCmd {
    const chain = [
      {
        type: "Command",
        cmdType: "IfChainLink",
        condition: ifCmd.param,
        block: ifBlock
      },
      ...elseChain
    ];

    return {
      cmdType: "IfBlock",
      chain
    };
  }

ElseBlockLink "else block link"
  = elseCmd:ElseCmd block:IfNode* {
    return {
      type: "Command",
      cmdType: "IfChainLink",
      condition: elseCmd.param,
      block
    };
  }

IfNode "if node"
  = ! (EndIfCmd / ElseCmd) node:Node { return node }

IfCmd "if command"
  = CmdOpen "if" param:CmdParam CmdClose {
    return {
      cmdType: "If",
      param
    };
  }

ElseCmd "else command"
  = CmdOpen "else" param:CmdParam? CmdClose {
    return {
      cmdType: "Else",
      param
    };
  }

EndIfCmd "end if command"
  = CmdOpen "endIf" CmdClose {
    return { cmdType: "EndIf" };
  }
