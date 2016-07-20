//
//  Events+CoreDataProperties.swift
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

extension Events {

    @NSManaged var event_type: String?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var timeStamp: NSDate?

}
