const range = function(start, end) {
  if (start === end) {
    return [];
  }
  return [start].push(range(start+1, end));
};

console.log(range(1,10));
// console.log(range(-6,10));
// console.log(range(8,10));
