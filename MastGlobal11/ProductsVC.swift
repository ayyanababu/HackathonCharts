//
//  ProductsVC.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 16/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let leftAndRightPaddings: CGFloat = 35.0
    private var numberOfItemsPerRow: CGFloat = 2.0
    private let heigthAdjustment: CGFloat = 30.0
    
    
    var vctitle: String?
    var products: [ProductModal]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.title = vctitle
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        if getDeviceWidth() > 375{
            numberOfItemsPerRow = 2.0
        }
        
        let width = (getDeviceWidth() - leftAndRightPaddings) / numberOfItemsPerRow
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSizeMake(width, 200)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.products?.count > 0 {
            return (self.products?.count)!
        }else{
            return 6
        }
    }
    
    private struct Storyboard
    {
        static let CellIdentifier = "productcell"
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier, forIndexPath: indexPath) as! ProductCell
        
        //let title = self.producttitles![indexPath.row]
        let product = self.products![indexPath.row]
        cell.configureCell(product, index: indexPath.row)
        
        return cell
    }

}


extension ProductsVC{
    
    @IBAction func favouriteButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func descriptoinButtonPressed(sender: AnyObject) {
        print("clicked on description button")
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showdescription"{
            
            //DataUtils.insertEvents("NAVIGATION", eventname: "CategoryToProducts Screen")

            
            let productController = segue.destinationViewController as? DescriptionVC
            if let cellbutton = sender as? UIButton{
                //let indexpath = self.collectionView!.indexPathForCell(cellbutton.tag)
                if self.products!.count > 0 {
                    let product = self.products![cellbutton.tag]
                    productController?.product = product
                    let productid = Int(product.prodTitle!)
                    DataUtils.insertEvents("NAVIGATION", eventname: "ProductDetail", qname: product.prodTitle, qtag: productid)

                }
                
            }
        }
    }
}


extension ProductsVC{
    func getDeviceWidth() -> CGFloat{
        let devicebounds = UIScreen.mainScreen().bounds
        let width = devicebounds.width
        return width
    }
}
