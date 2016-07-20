//
//  DataPersistance.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 17/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation
import CoreData

class DataPersistance{
    
    lazy var coreDataStack = CoreDataStack()
    
    
    let eventsArray: [[String: AnyObject?]] = [
        ["id":1,"name":"SEARCH","event_type":"KEY_UP"],
        ["id":7,"name":"SORT","event_type":"CLICK"],
        ["id":2,"name":"VIEW","event_type":"NAVIGATION"],
        ["id":3,"name":"DESCRIPTION","event_type":"BUTTON_PRESS"],
        
        ]
    
    let userSessionArray: [[String:AnyObject?]] = [
        ["user_id":11,"user_session_id":1101,"location":"BANGALORE"],
        ["user_id":12,"user_session_id":1201,"location":"MYSORE"],
        ["user_id":13,"user_session_id":1301,"location":"BANGALORE"],
        ["user_id":14,"user_session_id":1401,"location":"NEWYORK"],
        ["user_id":15,"user_session_id":1501,"location":"LONDON"],
        ["user_id":11,"user_session_id":1102,"location":"DURGAPUR"],
        ["user_id":12,"user_session_id":1202,"location":"PUNE"]
    ]
    
    let userArray: [[String: AnyObject?]] = [
        ["user_id":11,"email":"kartik@gmail.com","phone":1234,"age":18,"sex":"M","location":"BANGALORE"],
        ["user_id":12,"email":"amit@gmail.com","phone":1344,"age":45,"sex":"M","location":"MYSORE"],
        ["user_id":13,"email":"deepae@gmail.com","phone":9876,"age":18,"sex":"F","location":"BANGALORE"],
        ["user_id":14,"email":"ankita@gmail.com","phone":7890,"age":32,"sex":"F","location":"NEWYORK"],
        ["user_id":15,"email":"vinay@gmail.com","phone":8975,"age":34,"sex":"M","location":"LONDON"]
    ]
    let typeSpecArray : [[String : AnyObject?]] = [
        ["type_id":10, "q_name":nil,"q_tag":nil,"id":1,"user_session_id":1101],
        ["type_id":70, "q_name":nil,"q_tag":nil,"id":7,"user_session_id":1101],
        ["type_id":20, "q_name":"TOY","q_tag":200,"id":2,"user_session_id":1101],
        ["type_id":30, "q_name":nil,"q_tag":nil,"id":3,"user_session_id":1101],
        ["type_id":21, "q_name":"TOY","q_tag":201,"id":2,"user_session_id":1101],
        ["type_id":22, "q_name":"BAG","q_tag":210,"id":2,"user_session_id":1101],
        
        ["type_id":11, "q_name":nil,"q_tag":nil,"id":1,"user_session_id":1102],
        
        ["type_id":100, "q_name":nil,"q_tag":nil,"id":1,"user_session_id":1201],
        ["type_id":700, "q_name":nil,"q_tag":nil,"id":7,"user_session_id":1201],
        ["type_id":200, "q_name":"SHOES","q_tag":100,"id":2,"user_session_id":1201],
        ["type_id":201, "q_name":"SHOES","q_tag":101,"id":2,"user_session_id":1201],
        ["type_id":300, "q_name":nil,"q_tag":nil,"id":3,"user_session_id":1201],
        
        ["type_id":1000, "q_name":nil,"q_tag":nil,"id":1,"user_session_id":1401],
        ["type_id":7000, "q_name":nil,"q_tag":nil,"id":7,"user_session_id":1401],
        ["type_id":7001, "q_name":nil,"q_tag":nil,"id":7,"user_session_id":1401],
        ["type_id":3000, "q_name":nil,"q_tag":nil,"id":3,"user_session_id":1401]
        
    ]

    
    func insertDemoData(){
    
        
        for data in typeSpecArray{
            self.insertData("Type_Spec",props: data);
        }
        for data in eventsArray{
            self.insertData("Events",props: data);
        }
        for data in userSessionArray{
            self.insertData("User_Session",props: data);
        }
        for data in userArray{
            self.insertData("User",props: data);
        }
        

    }
    
    func insertData(tableName:String, props:[String: AnyObject?]){
        
        
        if tableName == "Events"{
            let evententity = NSEntityDescription.entityForName("Events", inManagedObjectContext: coreDataStack.managedObjectContext)
            
            let event = Events(entity:evententity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext) as? Events
            event!.id = props["id"] as? NSNumber
            event!.name  = props["name"] as? String
            event!.event_type = props["event_type"] as? String
            event!.timeStamp = NSDate()
            
            coreDataStack.saveMainContext()
            
        } else if tableName == "Type_Spec"{
            
            let evententity = NSEntityDescription.entityForName("Type_Spec", inManagedObjectContext: coreDataStack.managedObjectContext)
            
            let type_spec = Type_Spec(entity:evententity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext) as? Type_Spec
            type_spec!.id = props["id"] as? NSNumber
            type_spec!.type_id  = props["type_id"] as? NSNumber
            type_spec!.q_name = props["q_name"] as? String
            type_spec!.q_tag  = props["q_tag"] as? NSNumber
            type_spec!.user_session_id = props["user_session_id"] as? NSNumber
            // type_spec!.props = NSData()
            coreDataStack.saveMainContext()
            
        } else if tableName == "User"{
            
            let evententity = NSEntityDescription.entityForName("User", inManagedObjectContext: coreDataStack.managedObjectContext)
            
            let user = User(entity:evententity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext) as? User
            user!.user_id  = props["user_id"] as? NSNumber
            user!.email = props["email"] as? String
            user!.phone  = props["phone"] as? NSNumber
            user!.age = props["age"] as? NSNumber
            user!.sex = props["sex"] as? String
            user!.location = props["location"] as? String
            
            coreDataStack.saveMainContext()
            
        } else if tableName == "User_Session"{
            let evententity = NSEntityDescription.entityForName("User_Session", inManagedObjectContext: coreDataStack.managedObjectContext)
            
            let user_session = User_Session(entity:evententity!, insertIntoManagedObjectContext: coreDataStack.managedObjectContext) as? User_Session
            
            user_session!.user_session_id  = props["user_session_id"] as? NSNumber
            
            user_session!.log_in = NSDate()
            let today = NSDate()
            let tomorrow = NSCalendar.currentCalendar()
                .dateByAddingUnit(
                    .Day,
                    value: 1,
                    toDate: today,
                    options: []
            )
            
            user_session!.log_out  = tomorrow
            user_session!.time_out = NSDate()
            user_session!.location = props["location"] as? String
            user_session!.user_id = props["user_id"] as? NSNumber
            
            coreDataStack.saveMainContext()
        }
    }
    
    
    
    func retrieveData(tableName: String,predicateValue: [NSPredicate]!,property: [String]!) -> [NSManagedObject] {
        
        //var filteredResult: NSManagedObject?
        var arrayResults = [NSManagedObject]()
        
        
        //1
        let managedContext = coreDataStack.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: tableName)
        if(property.count > 0){
            fetchRequest.propertiesToFetch = property
        }
        
        //  fetchRequest.resultType = NSFetchRequestResultType.DictionaryResultType
        // fetchRequest.returnsDistinctResults = true
        fetchRequest.returnsObjectsAsFaults = false;
        // fetchRequest.predicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicateValue)
        fetchRequest.predicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: predicateValue)
        
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            arrayResults =  results as! [NSManagedObject]
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return arrayResults
        
    }
    
    
    
    func getRecord() -> [GlobalObject]{
        
        let typeSpecPredicate = NSPredicate(format:"type_id !=''")
        let typeSpecDistinct : [String] = ["user_session_id","id","q_name","type_id","q_tag"]
        var predicate = [NSPredicate]()
        predicate = [typeSpecPredicate]
        
        let objects = self.retrieveData("Type_Spec", predicateValue: predicate, property:typeSpecDistinct) as? [Type_Spec];
        var globalObjectArray = [GlobalObject]()
        
        if objects!.count > 0 {
            
            //var userSessionPredicate = "user_session_id IN ("
            for val in objects!{
                let globalObject = GlobalObject.init(id: Int(val.id!) , Int(val.type_id!), Int(val.user_session_id!));
                
                globalObject.q_name = String(val.q_name)
                globalObject.q_tag = String(val.q_tag)
                globalObjectArray.append(globalObject)
            }
            
            
            
            
            for item in globalObjectArray{
                let eventPredicate = NSPredicate(format:"id =%d", item.id);
                let eventDistinct : [String] = ["name","event_type"]
                var eventsPredicate = [NSPredicate]()
                eventsPredicate = [eventPredicate]
                let eventObjects = self.retrieveData("Events", predicateValue: eventsPredicate, property:eventDistinct) as? [Events];
                
                item.name = String(eventObjects![0].name!)
                item.event_type = String(eventObjects![0].event_type)
            }
            
            for item in globalObjectArray{
                let userSessionPredicate = NSPredicate(format:"user_session_id = %d",item.user_session_id)
                let userSessionDistinct : [String] = ["user_id"]
                var userSessionsPredicate = [NSPredicate]()
                userSessionsPredicate = [userSessionPredicate]
                let userSessionObjects = self.retrieveData("User_Session", predicateValue: userSessionsPredicate, property:userSessionDistinct) as? [User_Session];
                
                item.user_id = String(userSessionObjects![0].user_id!)
            }
            
            for item in globalObjectArray{
                let userPredicate = NSPredicate(format:"user_id =%d",Int(item.user_id!)!)
                let userPredicateDistinct : [String] = ["age","sex","location"]
                var usersPredicate = [NSPredicate]()
                usersPredicate = [userPredicate]
                let userObjects = self.retrieveData("User", predicateValue: usersPredicate, property:userPredicateDistinct) as? [User];
                
                
                
                if(Int(userObjects![0].age!) < 20){
                    item.age = "<20"
                }else if(Int(userObjects![0].age!) >= 20 && Int(userObjects![0].age!) <= 40){
                    item.age = "20-40"
                }else if(Int(userObjects![0].age!) > 40){
                    item.age = ">40"
                }
                item.sex = String(userObjects![0].sex!)
                item.location = String(userObjects![0].location!)
                
            }
            
            
        }
        return globalObjectArray
        
    }
    
    
    func getJsonData() -> NSString {
        var records = self.getRecord()
        var jsonCompatibleArray = [[String:[[String:String]]]]();

        
        
        
        for model in records
        {
            
            var obj =  [String:[[String:String]]]();
            
            let array:[[String:String]] = [
                [
                    "id":"id",
                    "value":String(model.id)
                ],
                [
                    "id":"type_id",
                    "value":String(model.type_id)
                ],
                [
                    "id":"user_session_id",
                    "value":String(model.user_session_id)
                ],
                [
                    "id":"q_name",
                    "value":model.q_name ?? ""
                ],
                [
                    "id":"q_tag",
                    "value":model.q_tag ?? ""
                ],
                [
                    "id":"age",
                    "value":model.age ?? ""
                ],
                [
                    "id":"location",
                    "value":model.location ?? ""
                ],
                [
                    "id":"user_id",
                    "value":model.user_id ?? ""
                ],
                [
                    "id":"event_type",
                    "value":model.event_type! ?? ""
                ],
                [
                    "id":"name",
                    "value":model.name ?? ""
                ],
                [
                    "id":"count",
                    "value":String(model.count) ?? ""
                ],
                [
                    "id":"sex",
                    "value":model.sex ?? ""
                ]
                
            ]
            
            obj["cells"] = array;
            jsonCompatibleArray.append(obj)
        }
        
        let jsonCompatibleData = [
            "structure":[
                
                "types":[[
                    "datatype":"STRING",
                    "id":"id"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"name"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"event_type"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"user_id"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"age"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"sex"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"location"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"type_id"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"q_name"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"user_session_id"
                    ],
                    [
                        "datatype":"NUMBER",
                        "id":"count"
                    ],
                    [
                        "datatype":"STRING",
                        "id":"q_tag"
                    ]
                ]
                
            ],
            
            "content": [
                "rows": jsonCompatibleArray
            ]
        ]
        
        do{
            let data = try NSJSONSerialization.dataWithJSONObject(jsonCompatibleData, options: .PrettyPrinted)
            let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding);
            return jsonString!;
        }catch let error as NSError {
            print(error)
        }
        
        return NSString(string:"");
    }
    
    
}