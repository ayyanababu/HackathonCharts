//
//  DisplayView.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

protocol DisplayViewDelegate{
    func showPopup(viewController:UIViewController)
}

class DisplayView: UIView,UIGestureRecognizerDelegate {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var data = [String:[String:ChartUnitData]]()
    var highValue:CGFloat = 0;
    var lowValue:CGFloat = 0;
    var xAxisKeys = [String]()
    var colorKeys = [String]()
    var showKeys = [String]()
    let colors = ReadColorsBundle.instance.getColors();
    var delegate:DisplayViewDelegate?
    var xAxisName:String?
    
    var startXKeyIndex:CGFloat = 0;
    var endXKeyIndex:CGFloat = 0;
    
}
