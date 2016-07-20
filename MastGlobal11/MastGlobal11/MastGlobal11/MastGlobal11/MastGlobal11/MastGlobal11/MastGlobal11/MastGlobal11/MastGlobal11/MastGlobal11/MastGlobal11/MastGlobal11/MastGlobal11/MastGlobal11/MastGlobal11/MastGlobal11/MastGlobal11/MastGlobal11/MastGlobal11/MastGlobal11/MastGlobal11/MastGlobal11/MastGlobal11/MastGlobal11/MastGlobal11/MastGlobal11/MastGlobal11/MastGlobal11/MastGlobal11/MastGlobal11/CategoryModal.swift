//
//  CategoryModal.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 16/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import Foundation


class CategoryModal {
    
    var categoryName: String?
    var categoryDesc: String?
    var categoryImage: String?
    
    init(name: String, desc:String, image: String){
        self.categoryName = name
        self.categoryDesc = desc
        self.categoryImage = image
        
    }
    
}