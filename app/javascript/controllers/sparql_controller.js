import { Controller } from "@hotwired/stimulus";

import { basicSetup } from "codemirror";
import { EditorView, keymap } from "@codemirror/view";
import { indentWithTab } from "@codemirror/commands";

export default class extends Controller {
  static targets = ["query", "results"];

  connect() {
    this.editor = new EditorView({
      extensions: [basicSetup, keymap.of([indentWithTab])],
      parent: this.queryTarget,
      doc: "SELECT * WHERE { ?subject ?predicate ?object } LIMIT 5",
    });
  }

  query(event) {
    event.preventDefault();

    const self = this;
    const sparqlQuery = self.editor.state.doc.text.join("\n");
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    if (!sparqlQuery) {
      return;
    }

    fetch("/sparql", {
      method: "POST",
      headers: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
      },

      body: JSON.stringify({ query: sparqlQuery }),
    })
      .then((response) => response.text())
      .then((data) => {
        self.resultsTarget.innerHTML = data;
      });
  }
}
