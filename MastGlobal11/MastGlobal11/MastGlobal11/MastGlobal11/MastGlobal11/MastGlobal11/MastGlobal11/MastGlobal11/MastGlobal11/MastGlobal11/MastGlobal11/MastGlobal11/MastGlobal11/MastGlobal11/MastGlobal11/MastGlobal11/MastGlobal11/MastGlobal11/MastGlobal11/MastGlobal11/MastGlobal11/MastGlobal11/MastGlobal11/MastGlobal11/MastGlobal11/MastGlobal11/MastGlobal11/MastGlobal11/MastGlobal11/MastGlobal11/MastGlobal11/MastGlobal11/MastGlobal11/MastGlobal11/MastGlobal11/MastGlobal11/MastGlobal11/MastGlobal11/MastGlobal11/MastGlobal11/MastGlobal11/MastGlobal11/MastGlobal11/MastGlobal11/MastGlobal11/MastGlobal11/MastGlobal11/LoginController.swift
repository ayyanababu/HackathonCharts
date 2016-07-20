//
//  LoginController.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 16/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    
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
            appdelegate?.loggedIn = true

        }else{
             appdelegate?.loggedIn = true
        }
        
    }
    
    
    
    

}
