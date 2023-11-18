import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
    console.log("Hello Controller Works!")
  }


  greet() {
    this.element.textContent = "Hello World!"
  }
}
