//
//  ViewController.swift
//  RealmBindingsDemo
//
//  Created by Guilherme Rambo on 10/07/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

import Cocoa
import RealmSwift

class ViewController: NSViewController {

    private var realm: Realm = {
        return try! Realm()
    }()
    
    @objc dynamic var people: [UserProfile] = []
    
    @objc dynamic var searchPredicate: NSPredicate?
    
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        notificationToken = realm.objects(UserProfile.self).addNotificationBlock { change in
            switch change {
            case .initial(let objects):
                self.people = Array(objects)
            case .update(let objects, _, _, _):
                self.people = Array(objects)
            case .error(let error):
                NSApp.presentError(error)
            }
        }
    }
    
    @IBAction func addNewUser(_ sender: Any) {
        let newUser = UserProfile()
        newUser.name = "NEW USER"
        
        try! realm.write {
            self.realm.add(newUser)
        }
    }
    
    @IBAction func searchUsers(_ sender: NSSearchField) {
        guard sender.stringValue.utf8.count >= 3 else {
            self.searchPredicate = nil
            return
        }
        
        self.searchPredicate = NSPredicate(format: "name contains[cd] %@ OR email contains[cd] %@", sender.stringValue, sender.stringValue)
    }
    
}

