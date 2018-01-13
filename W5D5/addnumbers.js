const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    reader.close();
  }
  if (numsLeft > 0 ) {
    reader.question("What is your number?", function (answer) {
      sum += parseInt(answer);
      console.log(sum);
      addNumbers(sum, numsLeft-1, completionCallback);

    });

  }
  // reader();

}

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
