import { basicSetup } from "codemirror";
import { EditorView, keymap } from "@codemirror/view";
import { indentWithTab } from "@codemirror/commands";
import { sparql } from "@codemirror/legacy-modes/mode/sparql";
import { StreamLanguage } from "@codemirror/language";
import { oneDark } from "@codemirror/theme-one-dark";

// Initialize a new editor with some extra defaults
function editor(options) {
  defaults = {
    extensions: [
      basicSetup,
      keymap.of([indentWithTab]),
      StreamLanguage.define(sparql),
      oneDark,
    ],

    ...options,
  };

  return new EditorView(defaults);
}

export { editor };
