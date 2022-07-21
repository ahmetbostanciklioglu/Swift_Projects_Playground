//
//  main.swift
//  Lazy_Stored_Lecture
//
//  Created by Ahmet Bostancıklıoğlu on 21.07.2022.
//

import Foundation



//MARK: - Lazy Var - Swift:

///A lazy stored property is a property whose initial value is not calculated until the first time it is used. You indicate a lazy stored property by writing the lazy modifier before its declaration.


///You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy.

struct InterviewCandidate {
   
    var isiOS: Bool?
    
    lazy var iOSResumeDescription: String = {
        return "I am an iOS developer"
    }()
    
    lazy var androidResumeDescription: String = {
        return "I am an android developer"
    }()
    
}

var person1 = InterviewCandidate()
person1.isiOS = true

if !person1.isiOS! {
    
    print(person1.iOSResumeDescription)
} else {
    
    print(person1.androidResumeDescription)
}


class InterviewTest {
    var name: String
    
    lazy var greeting: String = {
        
///Important to note: You can use self inside the closure of a lazy property. It will not cause any retain cycles. The reason is that the immediately applied closure {}() is considered @noescape. It does not retain the captured self
        
        return "Hello \(self.name)" //  No retain cycles here ..
        
    }()
    
    init(name: String) {
         self.name = name
    }
    
    lazy var iOSResumeDescription = "I am an iOS developer."
}

let testObject = InterviewTest(name: "Alli")

print(testObject.greeting)

print(testObject.iOSResumeDescription)



///Note: Remember, the point of lazy properties is that they are computed only when they are first needed, after which their value is saved. So, if you call the iOSResumeDescription for the second time, the previously saved value is returned.


///You can use lazy only with members of struct and class .

///Lazy variables are not initialised atomically and so is not thread safe.

///You can’t use it with computed properties . Because, a computed property returns the value every time we try to access it after executing the code inside the computation block.

///You can’t use lazy with let .
