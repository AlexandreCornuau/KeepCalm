import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  static values = {
    response: String,
    counter: Number
  }

  connect() {
    this.popModal()
  }


  // ouverture automatique de la modal
  popModal(event) {
    if (this.responseValue === "non" && this.counterValue >= 3) {
      setTimeout(()=>{this.modalTarget.style.display = "block";}, 10);
    }
  }
  // fermer la modal
  closeModal(event) {
    this.modalTarget.style.display = "none";
  }

  openModal(event) {
    this.modalTarget.style.display = "block";
   }
}
