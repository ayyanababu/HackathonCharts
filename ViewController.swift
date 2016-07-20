//
//  ViewController.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DashboardDelegate, UIAdaptivePresentationControllerDelegate, FilterDelegate{
    
    var dashboard:DashBoardView = DashBoardView.init(frame:CGRectZero);
    var index = 0
    var filtervalues:[String]?
    
    @IBOutlet weak var filterButton: UIButton!
    
    override func loadView() {
        self.view = dashboard;
//        if let path = NSBundle.mainBundle().pathForResource("output", ofType: "json")
//        {
//            if let jsonData = NSData(contentsOfFile: path)
//            {
//                var arrayX = ["location","age"];
//                var arrayY = ["q_name"];
//                var filter = "email";
//                var filterValues = ["Logged_in","Anonymus"];
//                
//                if(index == 1)
//                {
//                    //users who uses which controls and distribution over gender
//                    arrayX = ["name","sex"];
//                    arrayY = ["email"];
//                    filter = "location";
//                    filterValues = ["NEWYORK","BANGALORE","GERMANY","ENGLAND"];
//                    
//                }else if(index == 2)
//                {
//                    //session navigation over controllers from where section is coming location
//                    arrayX = ["event_type","location"];
//                    arrayY = ["user_session_id"];
//                    filter = "sex";
//                    filterValues = ["M","F"];
//                }
//                self.filtervalues = filterValues
//                self.dashboard.index = index;
//                self.dashboard.drawDashBoard(jsonData,nil,nil,arrayX,arrayY)
//            }
//        }
        
    }
    
    
    
    @IBAction func filterAction(sender: AnyObject) {
        print("tapped on filter")
        
        
        var popupWidth =  CGFloat(300)
        var popupHeight = CGFloat(90)
        let deviceType = UIDevice.currentDevice()

        
        if(deviceType == "ipad")
        {
            
            
            popupWidth =  CGFloat(400)
            popupHeight = CGFloat(100)
        }
        
        let storyboard = UIStoryboard(name: "Chart", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("popover") as! FilterPopover
        vc.filterdelegate = self
        if self.filtervalues?.count > 0 {
            vc.filterval = filtervalues
        }
        
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        vc.preferredContentSize = CGSizeMake(popupWidth, popupHeight)
        vc.popoverPresentationController?.sourceRect = CGRect(x: (self.view.frame.size.width - 20), y: 10, width:0, height:0);
        vc.popoverPresentationController?.sourceView = self.view;
        
    
        self.showPopup(vc)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dashboard.dashboardDelegate = self;
        index = DataUtils.generateRandomNumber(2)
        
        if let path = NSBundle.mainBundle().pathForResource("output", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                var arrayX = ["sex","age"];
                var arrayY = ["q_name"];
                var filter = "email";
                var filterValues = ["Logged_in","Anonymus"];
                
                if(index == 1)
                {
                    //users who uses which controls and distribution over gender
                    arrayX = ["name","sex"];
                    arrayY = ["location"];
                    filter = "location";
                    filterValues = ["NEWYORK","BANGALORE","GERMANY","ENGLAND"];
                    
                }else if(index == 2)
                {
                    //session navigation over controllers from where section is coming location
                    arrayX = ["event_type","location"];
                    arrayY = ["user_session_id"];
                    filter = "sex";
                    filterValues = ["M","F"];
                }
                self.filtervalues = filterValues
                self.dashboard.index = index;
                self.dashboard.drawDashBoard(jsonData,nil,nil,arrayX,arrayY)
            }
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPopup(viewController: UIViewController) {
        viewController.presentationController?.delegate = self;
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
    
    func selectedValue(value: String){
       // print("\(value)")
       self.dashboard.applyFilter(value);
    }

    
    
}

