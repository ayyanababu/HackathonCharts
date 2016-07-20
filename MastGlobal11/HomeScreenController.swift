//
//  HomeScreenController.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 16/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class HomeScreenController: UITableViewController {
    
    var categories = [CategoryModal]()
    var products = [String: [ProductModal]]()
    
    @IBOutlet weak var chartButton: UIBarButtonItem!
    
    
    struct storyboardconstants{
        static var SHOW_PRODUCTS = "showproducts"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorColor = UIColor.clearColor()
        self.setCategoryData()
        self.setProducts()

    }
    
    
    @IBAction func dashboardPressed(sender: AnyObject) {
        
        
        
        var storyBoard: UIStoryboard
        storyBoard = UIStoryboard(name: "Chart", bundle: nil)
        let init4inchViewController = (storyBoard.instantiateViewControllerWithIdentifier("dashboardhome") as? DashBoardListingVC)!
        
        
        self.navigationController?.pushViewController(init4inchViewController, animated: false);

    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.categories.count > 0{
            return self.categories.count
        }else{
            return 10
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? CategoryCell
        
        if self.categories.count > 0 {
            let category = categories[indexPath.row]
            cell?.configureCell(category)
        }

        // Configure the cell...
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == storyboardconstants.SHOW_PRODUCTS{
            
            let productController = segue.destinationViewController as? ProductsVC
            if let cellitem = sender as? CategoryCell{
                let indexpath = self.tableView!.indexPathForCell(cellitem)
                if self.categories.count > 0 {
                    
                    
                    DataUtils.insertEvents("NAVIGATION", eventname: "CategoryToProducts Screen", qname: nil, qtag: nil)
                    
                    let category = self.categories[(indexpath?.row)!]
                    productController?.vctitle = category.categoryName
                    
                    //categoryname
                    productController?.products = self.products[category.categoryName!]
                    
                    print("\(self.products[category.categoryName!])")
                }
                
            }
        
        }
        
    }
    
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.alpha = 0
        UIView.animateWithDuration(2.0) { 
            cell.alpha = 1
        }
//        
//        let rotateTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rotateTransform
//        
//        UIView.animateWithDuration(0.5) {
//            cell.layer.transform = CATransform3DIdentity
//        }
    }
    
    
 /*   func insertEvents(clicktype: String, eventname:String){
    
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
        
        
        self.insertTypeSpec(eventid, qname: nil, qtag: nil)
        
    }
    
    func insertTypeSpec(eventid: Int, qname: String?, qtag: String?){
        var typeid = DataUtils.generateRandomNumber(10)
        let appdelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let sessionid = appdelegate?.sessionid
        
        let typeSpecArray : [[String : AnyObject?]] = [
            ["type_id":typeid, "q_name":qname,"q_tag":qtag,"id":eventid,"user_session_id":sessionid]]
        
        let dataPersistance = DataPersistance()
        dataPersistance.insertData("Type_Spec", props: typeSpecArray[0])
        
        
        
    }*/
    
}





























extension HomeScreenController{
    func setCategoryData(){
        let category1 = CategoryModal(name: "Mens Collection", desc: "Mens Fashionable wear", image: "menuser")
        let category2 = CategoryModal(name: "Womens Collection", desc: "Womens Fashionable wear", image: "womenuser")
        let category3 = CategoryModal(name: "Kids Collection", desc: "Kids Fashionable wear", image: "kidsuser")
        let category4 = CategoryModal(name: "HomeDecor Collection", desc: "All About Lovely Home", image: "homefurniture")
        
        self.categories.append(category1)
        self.categories.append(category2)
        self.categories.append(category3)
        self.categories.append(category4)
        
    }
    
    func setProducts(){
        
        //mens category
        products["Mens Collection"] = [ProductModal]();
        products["Mens Collection"]?.append(self.product("campus Sutra Boomer Jacked", price: "7,567", imagename: "men1", prodid: "34251"))
        products["Mens Collection"]?.append(self.product("Mast & Harbour", price: "7,567", imagename: "men2", prodid: "34252"))
        products["Mens Collection"]?.append(self.product("Teakwood Leathers", price: "7,567", imagename: "men3", prodid: "34253"))
        products["Mens Collection"]?.append(self.product("Puma Jacket", price: "7,567", imagename: "men4", prodid: "34256"))
        products["Mens Collection"]?.append(self.product("Rebok Brown quilted", price: "7,567", imagename: "men5", prodid: "34254"))
        products["Mens Collection"]?.append(self.product("Black varsity jacket", price: "7,567", imagename: "men6", prodid: "34255"))
        
        //womens category
        products["Womens Collection"] = [ProductModal]();

        products["Womens Collection"]?.append(self.product("Alba women black jacket", price: "7,567", imagename: "women1", prodid: "24251"))
        products["Womens Collection"]?.append(self.product("Rare Printed top", price: "7,567", imagename: "women2", prodid: "24251"))
        products["Womens Collection"]?.append(self.product("Harpa Multicoloured", price: "7,567", imagename: "women3", prodid: "24251"))
        products["Womens Collection"]?.append(self.product("Athena", price: "7,567", imagename: "women4", prodid: "24251"))
        products["Womens Collection"]?.append(self.product("Renka Striped Top", price: "7,567", imagename: "women5", prodid: "24251"))
        products["Womens Collection"]?.append(self.product("Mango Printed Sleeves", price: "7,567", imagename: "women6", prodid: "24251"))
        
        //kids category
        products["Kids Collection"] = [ProductModal]();

        products["Kids Collection"]?.append(self.product("People boys shirt", price: "7,567", imagename: "kids1", prodid: "14251"))
        products["Kids Collection"]?.append(self.product("Dreamzone", price: "7,567", imagename: "kids2", prodid: "14253"))
        products["Kids Collection"]?.append(self.product("Oye shirt", price: "7,567", imagename: "kids3", prodid: "14254"))
        products["Kids Collection"]?.append(self.product("Puma shirt", price: "7,567", imagename: "kids4", prodid: "14255"))
        products["Kids Collection"]?.append(self.product("Reebok top", price: "7,567", imagename: "kids5", prodid: "14256"))
        products["Kids Collection"]?.append(self.product("Mango Printed Sleeves", price: "7,567", imagename: "kids6", prodid: "14252"))
        
        
        //home decor category
        products["HomeDecor Collection"] = [ProductModal]();

        products["HomeDecor Collection"]?.append(self.product("Raymond home", price: "7,567", imagename: "home1", prodid: "14251"))
        products["HomeDecor Collection"]?.append(self.product("Teakwood Leahers", price: "7,567", imagename: "home2", prodid: "14252"))
        products["HomeDecor Collection"]?.append(self.product("Reebok Brown Quilted", price: "7,567", imagename: "home3", prodid:"14253"))
        products["HomeDecor Collection"]?.append(self.product("double bed", price: "7,567", imagename: "home4", prodid: "142514"))
        products["HomeDecor Collection"]?.append(self.product("Lenin table cloth", price: "7,567", imagename: "home5", prodid: "142515"))
        products["HomeDecor Collection"]?.append(self.product("Table top", price: "7,567", imagename: "home6", prodid: "142516"))
        
        
    
    }
    
    
    func product(title: String, price: String, imagename: String, prodid: String) -> ProductModal{
        
         return ProductModal(title: title, price: price, image: imagename, prodid: prodid)
        
    }
}
