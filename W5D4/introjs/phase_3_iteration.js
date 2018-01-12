Array.prototype.bubbleSort = function() {
  let sorted = false;
  while (!sorted) {
    sorted = true;
    for (let i = 0; i < this.length - 1; i++) {
      let j = i + 1;
      if (this[i] > this[j]) {
        let tempI = this[i];
        let tempJ = this[j];
        this[i] = tempJ;
        this[j] = tempI;
        sorted = false;
      }
    }
  }
  return this;
};


// console.log([4,2,5,1,6].bubbleSort());


String.prototype.substrings = function() {
  let arr = [];
  for (let i = 0; i < this.length; i++) {
    for (let j = i + 1; j < this.length + 1; j++) {
      arr.push(this.slice(i, j));
    }
  }
  return arr;
}

// console.log("hello".substrings());
