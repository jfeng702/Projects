class Clock {
  constructor() {
    let date = new Date();
    this.hours = date.getHours();
    this.mins = date.getMinutes();
    this.secs = date.getSeconds();
    this.printTime();
    setInterval(this._tick.bind(this),1000);
  }

  printTime() {
    if (this.hours < 10) {
      this.hours = `0${this.hours}`;
    }
    if (this.mins < 10) {
      this.mins = `0${this.mins}`;
    }
    if (this.secs < 10) {
      this.secs = `0${this.secs}`;
    }
    // let time = `${this.hours}:${this.mins}:${this.secs}`;
    console.log(time);
  }

  _tick() {
    this.secs ++;
    if (this.secs > 59) {
      this.secs = 0;
      this.mins++;
    }

    if (this.mins > 59) {
      this.mins = 0;
      this.hours++;
    }

    if (this.hours > 23) {
      this.hours = 0;
    }

    this.printTime();
  }
}


let myclock = new Clock();
