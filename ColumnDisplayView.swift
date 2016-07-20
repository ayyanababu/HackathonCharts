//
//  ColumnDisplayView.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

class ColumnDisplayView: DisplayView {
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var barSpace:CGFloat = 0
    var maxBarWidth:CGFloat = 0
    
    var popupWidth: CGFloat = 0
    var popupHeight: CGFloat = 0
    
    override func layoutSubviews() {
        for view in self.subviews
        {
            view.removeFromSuperview();
        }
        
        self.drawChart();
    }
    
    func drawChart()
    {
        
        setSize()
        
        let xUnit = (self.frame.size.width)/CGFloat(self.xAxisKeys.count)
        let yUnit = (self.frame.size.height)/(highValue-lowValue)
        
        for (xIndex, xKey) in self.xAxisKeys.enumerate()
        {
            
            var barWidth = (xUnit-barSpace)/CGFloat(self.colorKeys.count)
            
            if(barWidth>maxBarWidth)
            {
                barWidth = maxBarWidth
            }
            
            if let pointsAtXKey = self.data[xKey]
            {
                
                for (colorIndex, colorKey) in self.colorKeys.enumerate()
                {
                    
                    let x = xUnit * CGFloat(xIndex) + (xUnit - (barWidth*CGFloat(self.colorKeys.count)))/2 + barWidth * CGFloat(colorIndex)
                    
                    if let chartUnit = pointsAtXKey[colorKey]
                    {
                        
                        let barHeight = chartUnit.value * yUnit
                        
                        let y = self.frame.size.height - barHeight
                        
                        let viewIndex = barViewIndex+(xIndex*self.colorKeys.count) + colorIndex
                        
                        if let view = self.viewWithTag(viewIndex)
                        {
                            view.frame = CGRectMake(x, y+barHeight, barWidth, 0)
                            UIView.animateWithDuration(2.0, delay: 0.0, options: [.CurveEaseInOut], animations: {view.frame.size.height = barHeight;view.frame.origin.y = y}, completion: nil)
                            
                        }else
                        {
                            let view = UIView.init(frame: CGRectMake(x, y+barHeight, barWidth, 0))
                            
                            let orgColorIndex = self.showKeys.indexOf(colorKey);
                            let index = orgColorIndex! % colors.count
                            view.backgroundColor = colors[index]
                            view.tag = viewIndex
                            self.addSubview(view)
                            
                            let touch = UITapGestureRecognizer.init(target: self, action: #selector(ColumnDisplayView.tapped(_:)))
                            touch.delegate = self;
                            view.addGestureRecognizer(touch);
                            
                            UIView.animateWithDuration(2.0, delay: 0.0, options: [.CurveEaseInOut], animations: {view.frame.size.height = barHeight;view.frame.origin.y = y}, completion: nil)
                        }
                        
                        
                    }
                    
                }
            }
        }
    }
    
    func tapped(recognizer:UITapGestureRecognizer)
    {
        let viewIndex = (recognizer.view?.tag)! - barViewIndex;
        let axisIndex = viewIndex/self.colorKeys.count;
        let colorIndex = viewIndex % self.colorKeys.count;
        let axisKey = self.xAxisKeys[axisIndex];
        let colorKey = self.colorKeys[colorIndex];
        
        let width = recognizer.view?.frame.size.width;
        
        if let pointsAtXKey = self.data[axisKey]
        {
            if let chartUnit = pointsAtXKey[colorKey]
            {
                let storyboard = UIStoryboard(name: "Chart", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("popup") as UIViewController
                
                vc.modalPresentationStyle = UIModalPresentationStyle.Popover
                vc.preferredContentSize = CGSizeMake(self.popupWidth, self.popupHeight)
                vc.popoverPresentationController?.sourceRect = CGRect(x: (width!/2), y: 1, width:0, height:0);
                vc.popoverPresentationController?.sourceView = recognizer.view;
                
                
                
                
                let popupView:PopupView = vc.view as! PopupView;
                popupView.header1?.text = xAxisName;
                popupView.header2?.text = chartUnit.colorName;
                popupView.label1?.text = chartUnit.xname;
                popupView.label2?.text = String(chartUnit.value);
                
                let index = colorIndex % colors.count
                popupView.header1?.textColor = colors[index]
                popupView.header2?.textColor = colors[index]
                
                delegate?.showPopup(vc);
                
            }
        }
        
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        
        self.maxBarWidth = CGFloat(30)
        self.barSpace = CGFloat(4)
        
        self.popupWidth =  CGFloat(300)
        self.popupHeight = CGFloat(60)
        
        if(deviceType == "ipad")
        {
            self.maxBarWidth = CGFloat(40)
            self.barSpace = CGFloat(6)
            
            self.popupWidth =  CGFloat(400)
            self.popupHeight = CGFloat(80)
        }
        
    }
    
    let barViewIndex = 1000;
}

