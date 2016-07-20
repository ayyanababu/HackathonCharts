//
//  LinesDisplayView.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit


class LinesDisplayView: DisplayView {
    
    var lineWidth:CGFloat = 0//1.5
    var radius:CGFloat = 0//2.0
    
    var popupWidth: CGFloat = 0
    var popupHeight: CGFloat = 0
    var isAnimated = false;
    
    let animateView:UIView;

    
    override init(frame: CGRect) {
        
        animateView = UIView.init(frame:frame);
        super.init(frame: frame);
        self.addSubview(animateView);
        animateView.backgroundColor = UIColor.whiteColor();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        setSize()
        
        if let currentContext = UIGraphicsGetCurrentContext(){
            
            CGContextClearRect(currentContext, rect)
            CGContextAddRect(currentContext, rect)
            CGContextSetRGBFillColor(currentContext,1.0,1.0,1.0,1.0)
            CGContextFillPath(currentContext)
            
            let xUnit = (self.frame.size.width)/CGFloat(self.xAxisKeys.count)
            let yUnit = (self.frame.size.height)/(highValue-lowValue)
            
            CGContextSetLineWidth(currentContext,lineWidth)
            
            for (colorIndex, colorKey) in self.colorKeys.enumerate()
            {
                
                var points = [CGPoint]();
                
                let orgColorIndex = self.showKeys.indexOf(colorKey);
                let index = orgColorIndex! % colors.count
                CGContextSetStrokeColor(currentContext, CGColorGetComponents(colors[index].CGColor))
                CGContextSetFillColor(currentContext, CGColorGetComponents(colors[index].CGColor))
                
                
                for (xIndex, xKey) in self.xAxisKeys.enumerate()
                {
                    
                    if let pointsAtXKey = self.data[xKey]
                    {
                        if let chartUnit = pointsAtXKey[colorKey]
                        {
                            
                            let x = xUnit * CGFloat(xIndex) + xUnit/2;
                            let y = self.frame.size.height - yUnit * chartUnit.value;
                            points.append(CGPointMake(x, y))
                            
                            
                            CGContextMoveToPoint(currentContext,x, y)
                            CGContextAddArc(currentContext,x,y,radius, radians(0),radians(360), 0);
                            CGContextClosePath(currentContext);
                            CGContextFillPath(currentContext);
                            
                            let viewIndex = lineViewIndex+(xIndex*self.colorKeys.count) + colorIndex
                            
                            if let view = self.viewWithTag(viewIndex)
                            {
                                view.frame = CGRectMake(x-20, y-20, 40, 40)
                                
                            }else
                            {
                                let view = UIView.init(frame: CGRectMake(x-20, y-20, 40, 40))
                                
                                view.backgroundColor = UIColor.clearColor();
                                view.tag = viewIndex
                                self.addSubview(view)
                                
                                let touch = UITapGestureRecognizer.init(target: self, action: #selector(LinesDisplayView.tapped(_:)))
                                touch.delegate = self;
                                view.addGestureRecognizer(touch);
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                
                
                CGContextAddLines(currentContext, points, points.count)
                CGContextStrokePath(currentContext)
                
            }
            
        }
        
        
    }
    
    func tapped(recognizer:UITapGestureRecognizer)
    {
        let viewIndex = (recognizer.view?.tag)! - lineViewIndex;
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
    
    
    let lineViewIndex = 1000;
    
    override func layoutSubviews(){
        
        if(!isAnimated)
        {
            self.animateView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            
            UIView.animateWithDuration(2.0, animations: {self.animateView.frame.origin.x = self.frame.size.width-10;}, completion:{isDone in  self.animateView.removeFromSuperview()})
            
            isAnimated = true;
        }
        
        self.setNeedsDisplay();
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        self.radius = CGFloat(5)
        self.lineWidth = CGFloat(1.5)
        self.popupWidth =  CGFloat(300)
        self.popupHeight = CGFloat(60)
        
        if(deviceType == "ipad")
        {
            self.radius = CGFloat(6)
            self.lineWidth = CGFloat(2.5)
            
            self.popupWidth =  CGFloat(400)
            self.popupHeight = CGFloat(80)
        }
        
        
    }
}
