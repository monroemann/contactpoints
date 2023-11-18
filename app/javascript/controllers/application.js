import { Application } from "@hotwired/stimulus"
// import "controllers"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

console.log("other javascript.js is being called");
console.log("why do we have two application.js?");