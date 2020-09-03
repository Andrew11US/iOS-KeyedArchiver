//
//  Person.swift
//  KeyedArchiver
//
//  Created by Andrew on 9/2/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {
    var name: String = ""
    var age: Int = 0
    
    convenience init(name: String, age: Int) {
        self.init()
        self.name = name
        self.age = age
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }
    
    required convenience init?(coder: NSCoder) {
        let name = coder.decodeObject(forKey: "name") as? String ?? ""
        let age = coder.decodeInteger(forKey: "age")
        self.init(name: name, age: age)
    }
}
