import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  connect() {
    const element = document.getElementById("messages");
    element.scrollTop = element.scrollHeight;
  }
  reset() {
    this.element.reset()
    const element = document.getElementById("messages");
    element.scrollTop = element.scrollHeight;
  }
}
