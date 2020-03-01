GameDialogScript
  = nodes:Node* {
    return {
      type: "Script",
      body: nodes
    };
  }

Node
  = Dialog / CmdNode / JSExpression

Dialog
  = (! (ExpOpen / CmdOpen) .)+ {
    const trimmedText = text();

    if (trimmedText === "") {
      return;
    }

    return {
      type: "Dialog",
      text: trimmedText
    };
  }
