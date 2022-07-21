//
//  main.swift
//  Retain_Cycle_Example
//
//  Created by Ahmet Bostancıklıoğlu on 21.07.2022.
//

import Foundation


class Pet2 {
    let name: String
    weak var owner: Owner2?

    init(name: String) {
        self.name = name
    }

    deinit {
        print("Pet deallocated")
    }
}

class Owner2 {
    let name: String
    var pet: Pet2?

    init(name: String) {
        self.name = name
    }
    deinit {
        print("Owner deallocated")
    }
}


var pet: Pet2? = Pet2(name: "Dog")
var owner: Owner2? = Owner2(name: "Alice")

pet!.owner = owner
owner!.pet = pet

pet = nil
owner = nil


class StopWatch {
    var elapsedTime: Int = 0
    var timer: Timer?


    func start() {
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
//            self?.elapsedTime += 1
//        })

//        Alternative way to the above closure type:


        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){  [weak self] _ in
            guard let self = self else { return  }
            self.elapsedTime += 1
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}


class Customer {
    let name: String
    var card: Card?
    
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
class Card {
    let number: UInt64
    
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}


var john: Customer?

john = Customer(name: "John Applesed")
john!.card = Card(number: 1234_5678_9087_6543, customer: john!)

john = nil


class Department2 {
    var name: String
    var courses: [Course2]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course2 {
    var name: String
    unowned var department: Department2
    unowned var nextCourse: Course2?
    init(name: String, in department: Department2) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}

let department = Department2(name: "Horticulture")

let intro = Course2(name: "Survey of Plants", in: department)
let intermediate = Course2(name: "Growing Common Herbs", in: department)
let advanced = Course2(name: "Caring for Tropical Plants", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced
department.courses = [intro, intermediate, advanced]



//var greeting : String = { [unowned self] in
//return “Hello \(self.name)”
//
//}()

//var greeting: String = { [weak self] _ in
//
//    var name = "Ahmet"
//    guard let strongSelf = self else {
//        return ""
//    }
//    return "Hello \(strongSelf.name)"
//
//}()
//


