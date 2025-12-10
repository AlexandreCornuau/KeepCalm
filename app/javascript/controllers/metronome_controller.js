import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="metronome"
export default class extends Controller {
  connect() {
    this.audio = new Audio('/beep.mp3');

    this.intervalId = setInterval(() => {
      this.audio.currentTime = 0;
      this.audio.play();
    }, 558);
  }

  disconnect() {

    if (this.intervalId) {
      clearInterval(this.intervalId);
    }


    if (this.audio) {
      this.audio.pause();
      this.audio.currentTime = 0;
    }
  }
}
