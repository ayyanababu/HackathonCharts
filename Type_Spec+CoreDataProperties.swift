//
//  Type_Spec+CoreDataProperties.swift
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

extension Type_Spec {

    @NSManaged var id: NSNumber?
    @NSManaged var q_name: String?
    @NSManaged var q_tag: NSNumber?
    @NSManaged var type_id: NSNumber?
    @NSManaged var user_session_id: NSNumber?

}
