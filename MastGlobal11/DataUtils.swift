//
//  DataUtils.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 17/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation
import UIKit

class DataUtils {
    
    static func generateRandomNumber(n: UInt32) -> Int{
        let diceRoll = Int(arc4random_uniform(n))
        return diceRoll
    }
    
    
    static func showSingleButtonAlert(titleText:String?, confirmText:String, msgText:String, showConfirm:Bool, style:UIAlertControllerStyle, viewController:UIViewController, alertHandler:( (String)-> ())) {
        
        
        let alertController = UIAlertController(title: titleText, message: msgText, preferredStyle: style)
        
        let actionRight = UIAlertAction(title:confirmText, style: .Default) { action in
            
            alertHandler("clicked on cancel")
        }
        
        alertController.addAction(actionRight)
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    
    static func insertEvents(clicktype: String, eventname:String,qname: String?, qtag: Int?){
        
        //if clicked on navigation type
        
        let typeid = DataUtils.generateRandomNumber(10)
        
        var eventid = 0
        if clicktype == "KEY_UP"{
            eventid = 1
        }else if clicktype == "CLICK"{
            eventid = 7
        }else if clicktype == "NAVIGATION"{
            eventid = 2
        }else{
            eventid = 3
        }
        
        
        let eventsArray: [[String: AnyObject?]] = [
            ["id":eventid,"name":eventname,"event_type":clicktype]]
        let dataPersistance = DataPersistance()
        dataPersistance.insertData("Events", props: eventsArray[0])
        
        
        self.insertTypeSpec(eventid, qname: qname, qtag: qtag)
        
    }
    
    static func insertTypeSpec(eventid: Int, qname: String?, qtag: Int?){
        let typeid = DataUtils.generateRandomNumber(10)
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let sessionid = appdelegate?.sessionid
        
        let typeSpecArray : [[String : AnyObject?]] = [
            ["type_id":typeid, "q_name":qname,"q_tag":qtag,"id":eventid,"user_session_id":sessionid]]
        
        let dataPersistance = DataPersistance()
        dataPersistance.insertData("Type_Spec", props: typeSpecArray[0])
        
        
        
    }

    
    
    

}
