import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btnDae", "modalDae", "closeDae"]

  connect() {
    this.element.addEventListener("click", (event) => {
      if (event.target == this.modalDaeTarget) {
        this.modalDaeTarget.style.display = "none";
      }
    })
  }

  openModal(event) {
    if (event.target == this.btnDaeTarget) {
      this.modalDaeTarget.style.display = "block";
    }
  }

  closeModal(event) {
    this.modalDaeTarget.style.display = "none";
  }
}
