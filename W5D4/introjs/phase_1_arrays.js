Array.prototype.myUniq = function() {
  let arr = [];
  for (let i = 0; i < this.length; i++) {
    if (!arr.includes(this[i])) {
      arr.push(this[i]);
    }
    else {
      continue;
    }
  }
  return arr;
};


// console.log([12,23,1,1,1,23].myUniq());


Array.prototype.twoSum = function() {
  let arr = [];
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        arr.push([i, j]);
      }
    }
  }
  return arr;
};

// console.log([-3, 0, 1, 3, 2, -1].twoSum());

Array.prototype.myTranspose = function() {
  let outer_arr = [];
  for (let i = 0; i < this.length; i ++) {
    outer_arr[i] = [];
    for (let j = 0; j < this.length; j++) {
      outer_arr[i][j] = this[j][i];
    }
  }
  return outer_arr;
};

// console.log([[1, 2, 3], [4, 5, 6], [7, 8, 9]].myTranspose());

// [ [1, 4, 7], [2, 5, 8], [3, 6, 9] ]
