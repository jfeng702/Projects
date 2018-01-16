// Function.prototype.inherits = function(Superclass) {
//   function Surrogate() {}
//   Surrogate.prototype = Superclass.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// };

Function.prototype.inherits = function(SuperClass) {
  this.prototype = Object.create(SuperClass.prototype);
  this.prototype.constructor = this;
};

function MovingObject (name, color) {
  this.name = name;
  this.color = color;
}

MovingObject.prototype.crash = function () {
  console.log('crashed');
};

MovingObject.prototype.sayName = function sayName() {
  console.log(this.name + ' moves!');
};

function Ship (name, coolColor) {
  MovingObject.call(this, name, coolColor);
}
Ship.inherits(MovingObject);

Ship.prototype.land = function () {
  console.log('landed');
};

function Asteroid () {}
Asteroid.inherits(MovingObject);
