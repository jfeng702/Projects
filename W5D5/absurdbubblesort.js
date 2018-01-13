
const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// function absurdBubblesort(arr, sortCompletionCallback) {
//
// }

function askIfGreaterThan(el, el2, callback) {
  console.log(`Is ${el} > ${el2}?`);
  reader.question('Is element 1 greater than element 2?', function(answer) {
    if (answer === 'yes') {
      callback(true);
    } else {
      callback(false);
    }
  });
}

function cb(input) {
  if (input === 'true') {
    let 
  }
  else {

  }
}

function innerBubbleSortLoop(arr, i ,madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], cb)
  }
}
