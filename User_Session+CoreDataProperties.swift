//
//  User_Session+CoreDataProperties.swift
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

extension User_Session {

    @NSManaged var location: String?
    @NSManaged var log_in: NSDate?
    @NSManaged var log_out: NSDate?
    @NSManaged var time_out: NSDate?
    @NSManaged var user_id: NSNumber?
    @NSManaged var user_session_id: NSNumber?

}
