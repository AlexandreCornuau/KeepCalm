import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { interval: Number, duration: Number }

  connect() {
    this.timer = setInterval(() => {
      this.showAlert()
    }, this.intervalValue)
  }

  disconnect() {
    clearInterval(this.timer)
    clearTimeout(this.hideTimeout)
  }

  showAlert() {
    this.element.classList.add("visible")

    this.hideTimeout = setTimeout(() => {
      this.element.classList.remove("visible")
    }, this.durationValue)
  }
}
