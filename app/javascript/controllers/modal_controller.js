import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["btnRecap", "btnDae", "modalRecap", "modalDae", "closeRecap", "closeDae"]

  connect() {
    this.element.addEventListener("click", (event) => {
      if (event.target == this.modalRecapTarget) {
        this.modalRecapTarget.style.display = "none";
      } else if (event.target == this.modalDaeTarget) {
        this.modalDaeTarget.style.display = "none";
      } else if (event.target == this.modalUrgenceTarget) {
        this.modalUrgenceTarget.style.display = "none";
      }
    })
  }

  openModal(event) {

    if (event.target == this.btnRecapTarget) {
      this.modalRecapTarget.style.display = "block";
    } else if (event.target == this.btnDaeTarget) {
      this.modalDaeTarget.style.display = "block";
    } else if (event.target == this.btnUrgenceTarget) {
      this.modalUrgenceTarget.style.display = "block";
    }
  }

  closeModal(event) {
    this.modalRecapTarget.style.display = "none";
    this.modalDaeTarget.style.display = "none";
    this.modalUrgenceTarget.style.display = "none";
  }
}
