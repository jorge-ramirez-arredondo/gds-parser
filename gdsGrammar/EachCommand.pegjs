// ## Each Loop Command Definition

EachCmdBlock "each command block"
  = eachCmd:EachCmd block:EachNode* EndEachCmd {

    return {
      cmdType: "eachBlock",
      param: eachCmd.param,
      block
    };
  }

EachNode "each node"
  = ! EndEachCmd node:Node { return node }

EachCmd "each command"
  = CmdOpen "each" param:CmdParam CmdClose {
    return {
      cmdType: "each",
      param
    };
  }

EndEachCmd "end each command"
  = CmdOpen "endEach" CmdClose {
    return { cmdType: "endEach" };
  }
