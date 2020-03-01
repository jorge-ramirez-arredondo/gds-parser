// # Command Definition Section

CmdNode "command node"
  = cmd:(PauseCmd / IfCmdBlock / EachCmdBlock) {
    return {
      type: "Command",
      ...cmd
    };
  }

CustomCmd "custom command"
  = CmdOpen cmdType:$[a-zA-Z]+ param:CmdParam? CmdClose {
    return {
      cmdType,
      param
    };
  }

// ## Command Definition Utility Rules

CmdOpen "command open"
  = "{{#"

CmdClose "command close"
  = "}}"

CmdParamJS "command param JS"
  = $(JSBlock / JSString / (! CmdClose .))+

CmdParam "command param"
  = _ js:CmdParamJS { return js }
