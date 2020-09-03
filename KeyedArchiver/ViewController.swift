//
//  ViewController.swift
//  KeyedArchiver
//
//  Created by Andrew on 9/2/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let person = Person(name: "John", age: 22)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        archive()
//
//        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
//            self.unarchive()
//        }
    }

    func archive() {
        do {
            let personData = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)
            UserDefaults.standard.set(personData, forKey: "personData")
            print("saved")
        } catch {
            print("Error!")
        }
    }
    
    func unarchive() {
        if let loadedData = UserDefaults.standard.object(forKey: "personData") as? Data {
            do {
                if let person = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(loadedData) as? Person {
                    print(person.name)
                    print(person.age)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Could not be loaded")
        }
    }
    
    // MARK: - Saving to the documents directory
    
    func saveToDirectory() {
        let person = Person(name: "Leo", age: 25)
        let randomFilename = UUID().uuidString
        let fullPath = getDocumentsDirectory().appendingPathComponent(randomFilename)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)
            try data.write(to: fullPath)
            print("Data saved to \(fullPath.absoluteString)")
            retrieveFromDirectory(path: fullPath)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func retrieveFromDirectory(path: URL) {
            do {
                let savedData = try Data(contentsOf: path)
                let person = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Person
                print(person?.name)
                print(person?.age)
            } catch let error {
                print(error.localizedDescription)
            }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        saveToDirectory()
    }
    @IBAction func getData(_ sender: UIButton) {
        
    }
}

