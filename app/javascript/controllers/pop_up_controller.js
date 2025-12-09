import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pop-up"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
  }

  show(event) {
    event.preventDefault()
    this.modalTarget.classList.remove("d-none")
  }

  return() {
    this.modalTarget.classList.add("d-none")
  }
}
