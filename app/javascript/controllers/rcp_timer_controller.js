import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { start: Number, end: Number }

  connect() {
    if (this.endValue) {
      // RCP terminée → on affiche la durée finale
      this.updateDuration(this.endValue * 1000)
    } else {
      // RCP en cours → mise à jour toutes les secondes
      this.update()
      this.interval = setInterval(() => this.update(), 1000)
    }
  }

  disconnect() {
    if (this.interval) clearInterval(this.interval)
  }

  update() {
    const now = Date.now()
    this.updateDuration(now)
  }

  updateDuration(currentTimeMs) {
    const startMs = this.startValue * 1000
    const diffSec = Math.floor((currentTimeMs - startMs) / 1000)

    const minutes = Math.floor(diffSec / 60)
    const seconds = diffSec % 60

    this.element.textContent = `${minutes}min ${seconds}s`
  }
}
