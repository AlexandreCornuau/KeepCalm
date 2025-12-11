import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="metronome"
export default class extends Controller {
  static targets = ["icon"]


  connect() {
    this.audioVoice = new Audio('/voice_higher.mp3')
    this.audio = new Audio('/beep.mp3');

    this.playVoice()
    this.isPlaying = true
  }

  playVoice(event){
    this.audioVoice.play();
    this.setTimeoutId = setTimeout(() => {
      this.playBeep();
    }, 3000);
  }

  playBeep(event) {
    this.intervalId = setInterval(() => {
      this.audio.currentTime = 0;
      this.audio.play();
    }, 558);
  }

  disconnect() {
    clearTimeout(this.setTimeoutId)
    this.muteBeep()
    this.muteVoice()
    this.isPlaying = false
  }

  muteBeep(event) {
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
    if (this.audio) {
      this.audio.pause();
      this.audio.currentTime = 0;
    }
  }

  muteVoice(event) {
   if (this.audioVoice) {
      this.audioVoice.pause();
    }
  }

  toggle(event) {
    if (this.isPlaying) {
      this.iconTarget.classList.remove("ph-speaker-simple-high")
      this.iconTarget.classList.add("ph-speaker-simple-slash")
      this.muteBeep()
      this.isPlaying = false
    }
    else {
      this.playBeep()
      this.iconTarget.classList.remove("ph-speaker-simple-slash")
      this.iconTarget.classList.add("ph-speaker-simple-high")
      this.isPlaying = true
    }
  }
}
