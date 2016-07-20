//
//  LoginController.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 16/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    lazy var coreDataAPI = DataPersistance()
    
    
    @IBOutlet weak var containerView: MaterialView!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: MaterialButton!
    @IBOutlet weak var skipButton: MaterialButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func LoginPressed(sender: AnyObject) {
        
        let clickedButton = sender as? MaterialButton
        let tag = clickedButton?.tag
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate


        if tag == 1{
            
            if userNameField.text == nil || userNameField.text == ""{
                self.showAlert("Failure", msg: "username should not be empty ")
                return
            }
            //while clicking on login button
            appdelegate?.loggedIn = true
            
            self.validate()

        }else{
            //while skipping button
             appdelegate?.loggedIn = true
            self.insertAnonymousData()
        }
        
    }
    
    func validate(){
        let typeSpecPredicate = NSPredicate(format:"email ='%@'",userNameField.text!)
        let typeSpecDistinct : [String] = ["user_id","email","phone","age","sex","location"]
        var predicate = [NSPredicate]()
        predicate = [typeSpecPredicate]
        
        let objects = coreDataAPI.retrieveData("User", predicateValue: predicate, property:typeSpecDistinct) as? [User];
        
        var user_id = 0;
        for object in objects!
        {
                if(object.email! == userNameField.text)
                {
                    if let id = object.user_id as? Int
                    {
                        user_id = id;
                        break;
                    }
                }
        }
        
        if (objects!.count == 0){
            var locationArray = ["NEWYORK","BANGALORE","GERMANY","FINALAND","ENGLAND","DENMARK","MUMBAI"]
            var age = [18,25,35,45,55,12,15,77,32]
            var phn = [9808,8789,1625,8316,8710,0987,1229,1232,0988]
            
            
            let randomNumber = DataUtils.generateRandomNumber(15523)
            let number = DataUtils.generateRandomNumber(6)
            
            user_id = randomNumber;
            let userArray: [[String: AnyObject?]] = [
                ["user_id":randomNumber,"email":userNameField.text!,"phone":phn[number],"age":age[number],"sex":"M","location":locationArray[number]]]
            let dataPersistance = DataPersistance()
            dataPersistance.insertData("User", props: userArray[0])
            
        }
        
        self.insertLoginData(user_id);
    }
    
    
    
    func showAlert(sucess: String, msg: String){
        DataUtils.showSingleButtonAlert(sucess, confirmText: "OK", msgText: msg, showConfirm: true, style: .Alert, viewController: self, alertHandler: { (data) -> () in
            
        })
    }

}


extension LoginController{

    func insertLoginData(user_id:Int){

        
        let user_session_id = DataUtils.generateRandomNumber(67890)
        let type_id = DataUtils.generateRandomNumber(99999)
        
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appdelegate?.sessionid = user_session_id
        
        let typeSpecArray : [[String : AnyObject?]] = [
            ["type_id":type_id, "q_name":nil,"q_tag":nil,"id":1,"user_session_id":user_session_id]]
        
        let userSessionArray: [[String:AnyObject?]] = [
            ["user_id":user_id,"user_session_id":user_session_id,"location":"BANGALORE"]]
        
        let eventsArray: [[String: AnyObject?]] = [
            ["id":1,"name":"Login","event_type":"LOGIN_TAP"]]
        
        let dataPersistance = DataPersistance()
        dataPersistance.insertData("User_Session", props: userSessionArray[0])
        dataPersistance.insertData("Type_Spec", props: typeSpecArray[0])
        dataPersistance.insertData("Events", props: eventsArray[0])
    }
    
    func insertAnonymousData() {
        
        var user_id = DataUtils.generateRandomNumber(99999)
        var locationArray = ["NEWYORK","BANGALORE","GERMANY","JAIPUR","FINALAND","ENGLAND","DENMARK","MUMBAI","JAMSHEDPUR"]
        var phn = [9808,8789,1625,8316,8710,0987,1229,1232,0988]
        var age = [18,25,35,45,55,12,15,77,32]
        
        var randomNumber = DataUtils.generateRandomNumber(6)
        
        var user_session_id = DataUtils.generateRandomNumber(67890)
        
        var type_id = DataUtils.generateRandomNumber(99999)
        
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appdelegate?.sessionid = user_session_id
        
        let userArray: [[String: AnyObject?]] = [
            ["user_id":user_id,"email":nil,"phone":phn[randomNumber],"age":age[randomNumber],"sex":"F","location":locationArray[randomNumber]]]
        
        
        let typeSpecArray : [[String : AnyObject?]] = [
            ["type_id":type_id, "q_name":nil,"q_tag":nil,"id":1,"user_session_id":user_session_id]]
        
        let userSessionArray: [[String:AnyObject?]] = [
            ["user_id":user_id,"user_session_id":user_session_id,"location":"BANGALORE"]]
        
        let eventsArray: [[String: AnyObject?]] = [
            ["id":1,"name":"Login","event_type":"LOGIN_TAP"]]
        
        var dataPersistance = DataPersistance()
        dataPersistance.insertData("User", props: userArray[0])
        dataPersistance.insertData("User_Session", props: userSessionArray[0])
        dataPersistance.insertData("Type_Spec", props: typeSpecArray[0])
        dataPersistance.insertData("Events", props: eventsArray[0])
        
        // let userArray
    }

}
