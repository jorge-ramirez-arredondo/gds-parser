// ## Each Loop Command Definition

EachCmdBlock "each command block"
  = eachCmd:EachCmd block:EachNode* EndEachCmd {

    return {
      cmdType: "EachBlock",
      param: eachCmd.param,
      block
    };
  }

EachNode "each node"
  = ! EndEachCmd node:Node { return node }

EachCmd "each command"
  = CmdOpen "each" param:CmdParam CmdClose {
    return {
      cmdType: "Each",
      param
    };
  }

EndEachCmd "end each command"
  = CmdOpen "endEach" CmdClose {
    return { cmdType: "EndEach" };
  }
