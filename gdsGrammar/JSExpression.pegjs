// # JS Expression Definition

JSExpression
  = ExpOpen js:JS ExpClose {
    return {
      type: "JSExpression",
      js: js.trim()
    };
  }

ExpOpen "expression open"
  = "{{"

ExpClose "expression close"
  = "}}"

JS
  = $(JSBlock / JSString / (! ExpClose .))+

JSBlock
  = JSBlockOpen JSBlockContent JSBlockClose

JSBlockContent
  = (JSBlock / JSString / (! JSBlockClose .))*

JSBlockOpen
  = "{"

JSBlockClose
  = "}"

JSString
  = JSSingleQuoteString / JSDoubleQuoteString / JSBacktickQuoteString

JSSingleQuoteString
  = SQ ("\\\\" / "\\'" / (! SQ .))* SQ

JSDoubleQuoteString
  = DQ ("\\\\" / "\\\"" / (! DQ .))* DQ

JSBacktickQuoteString
  = BQ ("\\\\" / "\\`" / "\\${" / JSBacktickInterpolation / (! BQ .))* BQ

JSBacktickInterpolation
  = "${" JSBlockContent "}"
