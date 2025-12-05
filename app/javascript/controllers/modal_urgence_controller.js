import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "modal", "close"]

  // connect() {
  //   this.element.addEventListener("click", (event) => {
  //     if (event.target == this.modalTarget) {
  //       this.modalTarget.style.display = "none";
  //     }
  //   })
  // }

  openModal(event) {
    if (event.target == this.btnTarget) {
      this.modalTarget.style.display = "block";
    }
  }

  closeModal(event) {
    this.modalTarget.style.display = "none";
  }
}
