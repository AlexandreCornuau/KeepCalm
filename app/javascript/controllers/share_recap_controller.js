import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-recap"
export default class extends Controller {
  static values = {
    url: String,
    title: String,
    text: String
  }

  async share(event) {
    event.preventDefault()

    if (navigator.share) {
      await this.shareWithWebAPI()
    } else {
      this.fallbackShare()
    }
  }

  async shareWithWebAPI() {
    try {
      const response = await fetch(this.urlValue)
      const blob = await response.blob()
      const file = new File([blob], "recap_intervention.pdf", { type: "application/pdf" })

      if (navigator.canShare && navigator.canShare({ files: [file] })) {
        await navigator.share({
          title: this.titleValue,
          text: this.textValue,
          files: [file]
        })
      } else {
        await navigator.share({
          title: this.titleValue,
          text: this.textValue
        })
      }
    } catch (error) {
      if (error.name !== "AbortError") {
        console.error("Erreur de partage:", error)
        this.fallbackShare()
      }
    }
  }

  fallbackShare() {
    window.open(this.urlValue, "_blank")
  }
}
