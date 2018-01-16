function sum() {

  let total = 0;
  for (var i = 0; i < arguments.length; i++) {

    // console.log(`arr is ${arr}`);
    total += arguments[i];
    // console.log(arr.slice(1)[i]);
  }
  return total;
}

sum(6,1,2,3,4);
sum(6,1,2,3,4,5);

function sumRest(...rest) {
  let total = 0;
  for (var i = 0; i < rest.length; i ++ ) {
    total += rest[i];
  }
  return total;
}

sumRest(6,1,2,3,4);
sumRest(6,1,2,3,4,5);

Function.prototype.myBind = function (ctx,...bindArgs) {
  return ((...callTimeArgs) => {
    this.apply(ctx, bindArgs.concat(callTimeArgs));
  });
};

Function.prototype.myBind = function(ctx) {
  let boundFunc = this;
  let bindArgs = Array.from(arguments).slice(1);
  return (function () {
    let callTimeArgs = Array.from(arguments);
    boundFunc.apply(ctx, bindArgs.concat(callTimeArgs));
  });
};

function curriedSum(numArgs) {
  let numbers = [];

  return (function _curriedSum(num){
    numbers.push(num);
    if (numbers.length === numArgs) {
      // return numbers.reduce((accum, el)=>accum+el);
      return numbers.reduce( function(accum, el) {
        return accum * el;
      });

      // let total = 0;
      //
      // for (var i = 0; i < numbers.length; i++) {
      //   total += numbers[i];
      // }
      //
      // return total;
    } else {
      return _curriedSum;
    }
  });
}

test = curriedSum(4);

Function.prototype.curry = function(numArgs) {
  let arr = [];
  let original = this;

  return (function _curry(num) {
    arr.push(num);
    if (arr.length === numArgs) {
      // return original(arguments);
      // return original.apply(null, arguments);
      return original(...arr);
    } else {
      return _curry;
    }
  });
};

let test2 = function sayHi() {
  return true;
};

let a = test2.curry(2);
console.log('a1', a(1));
console.log('a2', a(2));
