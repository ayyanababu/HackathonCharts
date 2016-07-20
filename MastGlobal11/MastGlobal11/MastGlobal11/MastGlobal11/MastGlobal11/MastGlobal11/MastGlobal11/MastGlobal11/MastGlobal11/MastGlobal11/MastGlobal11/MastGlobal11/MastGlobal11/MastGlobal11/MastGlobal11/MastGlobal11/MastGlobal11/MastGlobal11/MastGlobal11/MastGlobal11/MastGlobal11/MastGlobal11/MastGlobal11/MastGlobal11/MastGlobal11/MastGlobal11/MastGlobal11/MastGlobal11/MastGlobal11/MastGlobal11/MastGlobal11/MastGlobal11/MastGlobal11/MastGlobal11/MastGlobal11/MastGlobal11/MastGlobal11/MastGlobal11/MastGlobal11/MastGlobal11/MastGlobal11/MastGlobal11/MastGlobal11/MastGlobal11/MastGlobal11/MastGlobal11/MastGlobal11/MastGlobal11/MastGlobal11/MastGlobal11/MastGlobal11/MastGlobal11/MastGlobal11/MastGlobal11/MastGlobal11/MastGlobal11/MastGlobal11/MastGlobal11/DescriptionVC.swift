//
//  DescriptionVC.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 17/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {

    @IBOutlet weak var imageviewcontainer: MaterialView!
    @IBOutlet weak var imageview: UIImageView!
    
    
    @IBOutlet weak var prodtitle: UILabel!
    @IBOutlet weak var prodPrice: UILabel!
    @IBOutlet weak var prodSize: UILabel!
    @IBOutlet weak var proddesccription: UILabel!
    @IBOutlet weak var proddesc: UILabel!
    
    
    var product: ProductModal?
    
    
    
    override func viewDidLoad() {
        self.prodtitle.text = product?.prodTitle
        self.prodPrice.text = product?.prodPrice
        self.prodSize.text = "S M XL"
        self.proddesccription.text = "This is an awesome product"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.imageview.layer.cornerRadius = self.imageview.frame.size.width/2
        self.imageview.clipsToBounds = true
        self.imageview.layer.borderWidth = 2.0
        self.imageview.layer.borderColor = UIColor(red: 255.0 / 255.0, green: 45.0 / 255.0, blue: 85 / 255.0, alpha: 1.0).CGColor
        self.imageview.image = UIImage(named: (product?.prodImage)!)


    }
}
