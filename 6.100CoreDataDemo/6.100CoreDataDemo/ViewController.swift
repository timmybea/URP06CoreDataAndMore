//
//  ViewController.swift
//  6.100CoreDataDemo
//
//  Created by Tim Beals on 2016-12-09.
//  Copyright © 2016 Tim Beals. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Create a managed object contest with a reference to the persistent container which resides in the app delegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //Create a new managed object based on an entity and populate its attributes
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue("timmybea", forKey: "username")
        newUser.setValue("password123", forKey: "password")
        newUser.setValue(34, forKey: "age")
        
        //test that the persist was successful
        do {
            try context.save()
            print("Saved")
        } catch {
            print("There was an error")
        }
        
        //request the data to be returned as an array of entities
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //A managed object fault is an instance of the appropriate class, but its persistent variables are not yet initialized.
        //We want to return fully initialized objects so we will set this to false
        request.returnsObjectsAsFaults = false
        
        
        //Our fetch request will retrieve all managed objects of the type specified in our fetch request (entity)
        //NSFetchRequestResult is ALWAYS castable as NSManaged object
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "username") as? String {
                        print(username)
                    }
                }
            }
        } catch {
                print("Couldn't fetch results")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

