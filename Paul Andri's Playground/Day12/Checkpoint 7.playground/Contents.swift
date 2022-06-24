import UIKit


//CHECKPOINT 7

/*CHALLENGE:
 - Make a Class hierarchy for animals, starting with `Animal` at the top,
 - Then `Dog` and `Cat` as subClasses,
 - Then `Corgi' and `Poodle` as subClasses of `Dog`,
 - And* `Persian`and `Lion` as subClasses of `Cat`.

But there’s more:

1. The `Animal` Class should have a `legs` Integer Property that tracks how many legs the animal has.
2. The `Dog` Class should have a `speak()` Method that prints a generic dog barking string, but eaach of the subClasses should print something slightly different.
3. The `Cat` Class should have a matching `speak()` Method, again with each subclass printing something different.
4. The `Cat` Class should have an `isTame` Boolean Property, provided using an initializer.
*/



class Animal {
    var legs = 4
    
    init(legs: Int) {
        self.legs = legs
    }
}




class Dog: Animal {
    func speak() {
        print("Woof! Woof!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Woof! Woof! I'm a Corgi!")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Woof! Woof! I'm a Poddle!")
    }
}

let dog = Dog(legs: 4)
dog.speak()

let corgi = Corgi(legs: 4)
corgi.speak()

let poodle = Poodle(legs: 4)
poodle.speak()



class Cat: Animal {
    var isTame: Bool
    
    func speak() {
        if isTame {
            print("Meow! Meow! I'm a tame Cat!")
        } else {
            print("MEOW! I have \(legs) legs")
        }
    }
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
}

class Persiam: Cat {
    override func speak() {
        if isTame {
            print("Meow! Meow! I'm a tame Persian Cat!")
        } else {
            print("MEOW! I have \(legs) legs")
        }
    }
}

class Lion: Cat {
    override func speak() {
        if isTame {
            print("Roar! I'm a tame Lion!")
        } else {
            print("ROAR! I have \(legs) legs")
        }
    }
}

let cat = Cat(isTame: false, legs: 4)
cat.speak()

let persian = Persiam(isTame: true, legs: 4)
persian.speak()

let lion = Lion(isTame: false, legs: 4)
lion.speak()











