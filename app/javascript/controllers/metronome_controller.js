import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="metronome"
export default class extends Controller {
  static targets = ["icon"]

  connect() {
    this.audio = new Audio('/beep.mp3');

    this.play()
    this.isPlaying = true
  }

  play(event) {
    this.intervalId = setInterval(() => {
      this.audio.currentTime = 0;
      this.audio.play();
    }, 558);
  }

  disconnect() {
    this.mute()
    this.isPlaying = false
  }

  mute(event) {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }

    if (this.audio) {
      this.audio.pause();
      this.audio.currentTime = 0;
    }
  }

  toggle(event) {
    if (this.isPlaying) {
      this.iconTarget.classList.remove("ph-speaker-simple-high")
      this.iconTarget.classList.add("ph-speaker-simple-slash")
      this.mute()
      this.isPlaying = false
    }
    else {
      this.play()
      this.iconTarget.classList.remove("ph-speaker-simple-slash")
      this.iconTarget.classList.add("ph-speaker-simple-high")
      this.isPlaying = true
    }
  }
}
