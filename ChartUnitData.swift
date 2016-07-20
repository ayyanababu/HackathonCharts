//
//  ChartUnitData.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

class ChartUnitData: NSObject {
    
    var xname:String
    var value:CGFloat
    var colorName:String
    
    init(xname: String,colorName:String,value:CGFloat) {
        
        self.xname = xname
        self.value = value
        self.colorName = colorName
        super.init()
    }
    
}