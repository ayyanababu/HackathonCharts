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
    
    
    
    struct storyboardconstants{
        static var SHOW_PRODUCTS = "showproducts"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorColor = UIColor.clearColor()
        self.setCategoryData()
        self.setProducts()

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
                    let category = self.categories[(indexpath?.row)!]
                    productController?.vctitle = category.categoryName
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
        
//        let rotateTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
//        cell.layer.transform = rotateTransform
//        
//        UIView.animateWithDuration(0.5) {
//            cell.layer.transform = CATransform3DIdentity
//        }
    }
    
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
        products["Mens Collection"]?.append(self.product("campus Sutra Boomer Jacked", price: "7,567", imagename: "men1", prodid: "34251M"))
        products["Mens Collection"]?.append(self.product("Mast & Harbour", price: "7,567", imagename: "men2", prodid: "34252M"))
        products["Mens Collection"]?.append(self.product("Teakwood Leathers", price: "7,567", imagename: "men3", prodid: "34253M"))
        products["Mens Collection"]?.append(self.product("Puma Jacket", price: "7,567", imagename: "men4", prodid: "34256M"))
        products["Mens Collection"]?.append(self.product("Rebok Brown quilted", price: "7,567", imagename: "men5", prodid: "34254M"))
        products["Mens Collection"]?.append(self.product("Black varsity jacket", price: "7,567", imagename: "men6", prodid: "34255M"))
        
        //womens category
        products["Womens Collection"] = [ProductModal]();

        products["Womens Collection"]?.append(self.product("Alba women black jacket", price: "7,567", imagename: "women1", prodid: "24251W"))
        products["Womens Collection"]?.append(self.product("Rare Printed top", price: "7,567", imagename: "women2", prodid: "24251W"))
        products["Womens Collection"]?.append(self.product("Harpa Multicoloured", price: "7,567", imagename: "women3", prodid: "24251W"))
        products["Womens Collection"]?.append(self.product("Athena", price: "7,567", imagename: "women4", prodid: "24251W"))
        products["Womens Collection"]?.append(self.product("Renka Striped Top", price: "7,567", imagename: "women5", prodid: "24251W"))
        products["Womens Collection"]?.append(self.product("Mango Printed Sleeves", price: "7,567", imagename: "women6", prodid: "24251W"))
        
        //kids category
        products["Kids Collection"] = [ProductModal]();

        products["Kids Collection"]?.append(self.product("People boys shirt", price: "7,567", imagename: "kids1", prodid: "14251k"))
        products["Kids Collection"]?.append(self.product("Dreamzone", price: "7,567", imagename: "kids2", prodid: "14251k"))
        products["Kids Collection"]?.append(self.product("Oye shirt", price: "7,567", imagename: "kids3", prodid: "14251k"))
        products["Kids Collection"]?.append(self.product("Puma shirt", price: "7,567", imagename: "kids4", prodid: "14251k"))
        products["Kids Collection"]?.append(self.product("Reebok top", price: "7,567", imagename: "kids5", prodid: "14251k"))
        products["Kids Collection"]?.append(self.product("Mango Printed Sleeves", price: "7,567", imagename: "kids6", prodid: "14251k"))
        
        
        //home decor category
        products["HomeDecor Collection"] = [ProductModal]();

        products["HomeDecor Collection"]?.append(self.product("Raymond home", price: "7,567", imagename: "home1", prodid: "14251h"))
        products["HomeDecor Collection"]?.append(self.product("Teakwood Leahers", price: "7,567", imagename: "home2", prodid: "14251h"))
        products["HomeDecor Collection"]?.append(self.product("Reebok Brown Quilted", price: "7,567", imagename: "home3", prodid:"14251h"))
        products["HomeDecor Collection"]?.append(self.product("double bed", price: "7,567", imagename: "home4", prodid: "14251h"))
        products["HomeDecor Collection"]?.append(self.product("Lenin table cloth", price: "7,567", imagename: "home5", prodid: "14251h"))
        products["HomeDecor Collection"]?.append(self.product("Table top", price: "7,567", imagename: "home6", prodid: "14251h"))
        
        
    
    }
    
    
    func product(title: String, price: String, imagename: String, prodid: String) -> ProductModal{
        
         return ProductModal(title: title, price: price, image: imagename, prodid: prodid)
        
    }
}
