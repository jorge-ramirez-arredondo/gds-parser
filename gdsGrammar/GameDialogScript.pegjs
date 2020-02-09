GameDialogScript
  = Node*

Node
  = Dialog / CmdNode / JSExpression

Dialog
  = (! (ExpOpen / CmdOpen) .)+ {
    const trimmedText = text().trim();

    if (trimmedText === "") {
      return null;
    }

    return {
      type: "dialog",
      text: trimmedText
    };
  }
