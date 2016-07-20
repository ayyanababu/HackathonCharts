//
//  DashBoardListingVC.swift
//  Dashboard
//
//  Created by administrator on 17/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

class DashBoardListingVC: UITableViewController {
    
    
    struct StoryBoardConstants{
        static let CELL_IDENTIFIER = "chartlistingcell"
        static let DASHBOARD_VIEW = "showDashboard"
    }
    
    
    var dashboardList:[String] = ["Users Cound","Age vs Controls","Navigation Dashboard"];
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.separatorColor = UIColor.clearColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dashboardList.count > 0 {
            return self.dashboardList.count
        }else{
            return 1
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoardConstants.CELL_IDENTIFIER, forIndexPath: indexPath)
        
        //cell.textLabel?.text = "Ayyan"
        cell.imageView?.image = UIImage(named: "analytics")
        cell.textLabel?.text = dashboardList[indexPath.row]
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
       let navcontroller = segue.destinationViewController as? UINavigationController
    
        if segue.identifier == StoryBoardConstants.DASHBOARD_VIEW{
          let destinationcontroller = navcontroller?.topViewController as? ViewController
            //let destinationcontroller = segue.destinationViewController as? ViewController
            if let cellitem = sender as? UITableViewCell{
                let indexpath = self.tableView!.indexPathForCell(cellitem)
                destinationcontroller?.index = (indexpath?.row)!
                print("\(indexpath!.row)")
            }
        }
        
    }
}
