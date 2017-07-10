//
//  Person.swift
//  RealmBindingsDemo
//
//  Created by Guilherme Rambo on 10/07/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

import Cocoa
import RealmSwift

public final class UserProfile: ModelObject {
    
    @objc public dynamic var identifier: String = UUID().uuidString
    @objc public dynamic var name: String = ""
    @objc public dynamic var email: String = ""
    
    public let referred = List<UserProfile>()
    public let referrer = LinkingObjects(fromType: UserProfile.self, property: "referred")
    
}
