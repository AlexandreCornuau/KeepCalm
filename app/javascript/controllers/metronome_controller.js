import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="metronome"
export default class extends Controller {

  connect() {
    const audio = new Audio('/beep.mp3');


    setInterval(() => {
      audio.currentTime = 0;
      audio.play();
    }, 558);
  }

}
