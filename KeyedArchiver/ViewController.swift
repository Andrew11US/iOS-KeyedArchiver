//
//  ViewController.swift
//  KeyedArchiver
//
//  Created by Andrew on 9/2/20.
//  Copyright © 2020 Andrii Halabuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fileURL: URL?
    let person = Person(name: "John", age: 22)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Saving to UserDefaults using NSKeyedArchiver
    func archive(person: Person) {
        do {
            let personData = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)
            UserDefaults.standard.set(personData, forKey: "personData")
        } catch {
            print("Error!")
        }
    }
    
    func unarchive() {
        if let loadedData = UserDefaults.standard.object(forKey: "personData") as? Data {
            do {
                if let person = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(loadedData) as? Person {
                    print("UD: \(person.name) is \(person.age)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("No data for key provided")
        }
    }
    
    // MARK: - Saving to the documents directory
    func saveToDirectory() -> URL? {
        let person = Person(name: "Leo", age: 25)
        let randomFilename = UUID().uuidString
        let fullPath = getDocumentsDirectory().appendingPathComponent(randomFilename)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: person, requiringSecureCoding: false)
            try data.write(to: fullPath)
            return fullPath
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func retrieveFromDirectory(path: URL) {
            do {
                let savedData = try Data(contentsOf: path)
                if let person = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? Person {
                    print("\(person.name) is \(person.age)")
                }
            } catch let error {
                print(error.localizedDescription)
            }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        fileURL = saveToDirectory()
        print("Saved to \(String(describing: fileURL?.absoluteString ?? ""))")
    }
    @IBAction func getData(_ sender: UIButton) {
        guard let url = fileURL else { return }
        retrieveFromDirectory(path: url)
    }
    
    @IBAction func saveToDefaults(_ sender: UIButton) {
        archive(person: person)
        print("Saved to UserDefaults")
    }
    @IBAction func getFromDefaults(_ sender: UIButton) {
        unarchive()
    }
}

