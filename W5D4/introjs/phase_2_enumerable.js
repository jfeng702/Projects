function logIfEven(num) {
  if (num % 2 === 0) {
    console.log(`${num} is an even number!`);
  }
}

function doubler(num) {
  return num * 2;
}


Array.prototype.myEach = function(callback) {
  for (let i = 0; i < this.length; i++) {
    callback(this[i]);
  }
};

// console.log([1,5,2,3,6].myEach(doubler));


Array.prototype.myMap = function(callback) {
  let arr = [];
  // arr.push(this.myEach(callback));
  this.myEach(el=>{
    arr.push(callback(el));
  });
  return arr;
};

// console.log([1,5,2,3,6].myMap(doubler));


Array.prototype.myReduce = function(callback, initialValue) {
  let arr = this;
  if (!initialValue) {
    initialValue = arr.shift();
  }

  arr.myEach(el => {
    initialValue = callback(initialValue, el);
  });
  return initialValue;
};

// without initialValue
// console.log([1, 2, 3].myReduce(function(acc, el) {
//   return acc + el;
// })); // => 6

// with initialValue
// console.log([1, 2, 3].myReduce(function(acc, el) {
//   return acc + el;
// }, 25)); // => 31
