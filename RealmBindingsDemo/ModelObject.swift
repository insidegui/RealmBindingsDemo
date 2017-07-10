//
//  ModelObject.swift
//  RealmBindingsDemo
//
//  Created by Guilherme Rambo on 10/07/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

import Cocoa
import RealmSwift

public class ModelObject: Object {
    
    @objc public override func setValue(_ value: Any?, forKey key: String) {
        // make sure we begin a write transaction if this is a managed object
        self.realm?.beginWrite()
        
        // actually do the update
        super.setValue(value, forKey: key)
        
        // commit the write transaction if managed
        // this will crash if the write fails, in the real world you'd want to use do { } catch { }
        try! self.realm?.commitWrite()
    }
    
}
