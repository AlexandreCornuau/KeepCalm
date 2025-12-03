import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ["btn", "modal", "close"]

  connect() {
    this.element.addEventListener("click", (event) => {
      if (event.target == this.modalTarget) {
        this.modalTarget.style.display = "none";
      }
    })
  }
  openModal() {
    this.modalTarget.style.display = "block";
  }

  closeModal() {
    this.modalTarget.style.display = "none";
  }

}
