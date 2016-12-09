//
//  ViewController.swift
//  6.100CoreDataChallenge
//
//  Created by Tim Beals on 2016-12-09.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var isUserFound = false
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.isHidden = true
    }

    
    @IBAction func submitButtonTouched(_ sender: AnyObject) {
        isUserFound = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
                for result in results as! [NSManagedObject] {
                    let name = result.value(forKey: "name") as? String
                    if name == nameTextField.text {
                        isUserFound = true
                        messageLabel.isHidden = false
                        messageLabel.text = "Welcome back " + name!
                    }
                }
                if isUserFound == false {
                    messageLabel.isHidden = false
                    messageLabel.text = "Please register as a user"
                }
        } catch {
            print("Couldn't fetch the results")
        }
    }

    @IBAction func saveButtonTouched(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue(nameTextField.text, forKey: "name")
        newUser.setValue(usernameTextField.text, forKey: "username")
        newUser.setValue(passwordTextField.text, forKey: "password")
        
        do {
            try context.save()
            print("Saved")
        } catch {
            print("There was an error")
        }
    }
}

