//
//  User+CoreDataProperties.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 17/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var age: NSNumber?
    @NSManaged var email: String?
    @NSManaged var location: String?
    @NSManaged var phone: NSNumber?
    @NSManaged var sex: String?
    @NSManaged var user_id: NSNumber?

}
