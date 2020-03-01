// ## Pause Command Definition

PauseCmd "pause command"
  = CmdOpen "pause" CmdClose {
    return {
      cmdType: "Pause"
    };
  }
