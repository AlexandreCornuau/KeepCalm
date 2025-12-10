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


+    static targets = ["icon"]
        6 +
        7      connect() {
        8        this.audio = new Audio('/beep.mp3');
        9 +      this.isPlaying = true;
       10
       11 +      this.startMetronome();
       12 +    }
       13 +
       14 +    startMetronome() {
       15        this.intervalId = setInterval(() => {
       16          this.audio.currentTime = 0;
       17          this.audio.play();
       18        }, 558);
       19      }
       20
       21 -    disconnect() {
       22 -
       21 +    stopMetronome() {
       22        if (this.intervalId) {
       23          clearInterval(this.intervalId);
       24 +        this.intervalId = null;
       25        }
       26 -
       27 -
       26        if (this.audio) {
       27          this.audio.pause();
       28          this.audio.currentTime = 0;
       29        }
       30      }
       31 +
       32 +    toggle() {
       33 +      if (this.isPlaying) {
       34 +        this.stopMetronome();
       35 +        this.iconTarget.classList.remove("ph-speaker-simple-high");
       36 +        this.iconTarget.classList.add("ph-speaker-simple-slash");
       37 +      } else {
       38 +        this.startMetronome();
       39 +        this.iconTarget.classList.remove("ph-speaker-simple-slash");
       40 +        this.iconTarget.classList.add("ph-speaker-simple-high");
       41 +      }
       42 +      this.isPlaying = !this.isPlaying;
       43 +    }
       44 +
       45 +    disconnect() {
       46 +      this.stopMetronome();
       47 +    }
       48    }
