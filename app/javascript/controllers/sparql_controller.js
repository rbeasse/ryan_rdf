import { Controller } from "@hotwired/stimulus";
import { editor } from "../lib/codemirror";

export default class extends Controller {
  static targets = ["query", "results"];
  static values = { url: String };

  connect() {
    this.editor = editor({
      parent: this.queryTarget,
      doc: "SELECT * WHERE { ?subject ?predicate ?object } LIMIT 5",
    });
  }

  query() {
    const self = this;
    const sparqlQuery = self.editor.state.doc.text.join("\n");
    const csrfToken = document.querySelector("[name='csrf-token']").content;

    if (!sparqlQuery) {
      return;
    }

    self.resultsTarget.innerHTML = `<span class="loader"></span>`;

    fetch(this.urlValue, {
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
