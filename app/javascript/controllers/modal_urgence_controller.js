import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "btn", "modal"]
  static values = {
    response: String,
    counter: Number
  }

  connect() {
    this.popModal()
    this.hideBtn()
    this.hideForm()
  }


  // ouverture automatique de la modal si personne est en arrêt cardiaque
  popModal(event) {
    if (this.responseValue === "non" && this.counterValue >= 3) {
      this.modalTarget.style.display = "block";
    }
  }

  // fermer la modal
  closeModal(event) {
    this.modalTarget.style.display = "none";
  }

  // ré-ouvrir la modal via le bouton
  openModal(event) {
    this.modalTarget.style.display = "block";
   }


  // bouton non visible si la victime respire
  hideBtn(event) {
    if (this.responseValue === "oui" && this.counterValue >= 3) {
    this.btnTarget.classList.add("d-none")
    }
  }

   hideForm(event) {
    if (this.responseValue === "oui" && this.counterValue >= 2) {
    this.formTarget.classList.add("d-none")
    }
  }

}
