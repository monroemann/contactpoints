import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="search"
export default class extends Controller {

  // static targets = ["input", "suggestions"];

  connect() { 
    console.log("YES search controller working - connect method called", this.element);
    new TomSelect(this.element, {
      createOnBlur: true,
      create: true
    });
    // document.addEventListener("click", (event) => { // <-- Corrected syntax
    //   if (!this.element.contains(event.target)) {
    //     this.hideSuggestions();
    //   }
    // });
  }

  
  suggestions() {
    console.log("Suggestion Function Running");
    const query = this.inputTarget.value;
    const url = this.element.dataset.suggestionsUrl;

    clearTimeout(this.setTimeout)

    this.timeout = setTimeout(()=> {
      this.requestSuggestions(query,url);
    }, 250);
  }

  requestSuggestions(query, url) {
    if (query.length === 0) {
      this.hideSuggestions();
      return;
    }
    
    this.showSuggestions();
    
    fetch (url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content
      },
        body: JSON.stringify ({query: query}),
    }).then(response => {
      response.text().then( html => {
        document.body.insertAdjacentHTML("beforehand", "html");
      })
    })
  }

  hideSuggestions() {
    if (!this.childWasClicked) {
      this.suggestionsTarget.classList.add("hidden");
    }
    this.childWasClicked = false;
  }

  showSuggestions() {
    this.suggestionsTarget.classList.remove("hidden");
  }

}