import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "modalDiag", "close", "diag"]
  static values = {
    response: String,
    counter: Number
  }

  connect() {
    console.log(this.modalDiagTarget);
  }



  // ouverture automatique de la modal
  popModal(event) {
    if (this.responseValue === "non" && this.counterValue >= 2) {
      this.modalDiagTarget.style.display = "block";
    } else {
      console.log("pas value");
    }
  }
  // fermer la modal
  closeModal(event) {
    this.modalDiagTarget.style.display = "none";
  }

  // openModal(event) {
    // if (event.target == this.btnTarget) {
      // this.modalTarget.style.display = "block";
    // }
   // }
}
