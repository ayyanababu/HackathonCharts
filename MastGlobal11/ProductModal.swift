//
//  ProductModal.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 17/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation

class ProductModal {
    
    var prodTitle: String?
    var prodPrice: String?
    var prodImage: String?
    var prodid: String?
    
    init(title: String, price:String, image: String, prodid: String){
        self.prodTitle = title
        self.prodPrice = price
        self.prodImage = image
        self.prodid = prodid
        
    }
    
       
}