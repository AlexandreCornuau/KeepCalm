import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="auto-progress"
export default class extends Controller {
  static values = {
    duration: { type: Number, default: 6000 } // durée en ms
  }

  connect() {
    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersection(entries),
      { threshold: 0.5 } // 50% du bouton visible
    )
    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
    this.cancelProgress()
  }

  handleIntersection(entries) {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        this.startProgress()
      } else {
        this.cancelProgress()
      }
    })
  }

  startProgress() {
    if (this.isRunning) return

    this.isRunning = true
    this.element.classList.add("auto-progress--active")

    this.timeout = setTimeout(() => {
      window.location.href = this.element.href
    }, this.durationValue)
  }

  cancelProgress() {
    this.isRunning = false
    this.element.classList.remove("auto-progress--active")

    if (this.timeout) {
      clearTimeout(this.timeout)
      this.timeout = null
    }
  }
}
