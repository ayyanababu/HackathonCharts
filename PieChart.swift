//
//  PieChart.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

protocol pieDelegate {
    func showPopup(viewController:UIViewController)
}

struct arcAngle {
    var startAngle: CGFloat
    var endAngle: CGFloat
}

class PieChart: UIView {
    
    var popupWidth: CGFloat = 0
    var popupHeight: CGFloat = 0
    var isAnimated = false;
    
    
    var total:CGFloat = 0;
    let data:[String:ChartUnitData];
    let colorKeys:[String];
    let colors = ReadColorsBundle.instance.getColors();
    let legendView:LegendView;
    let titleView:UILabel;
    var holdEndofArcPoints = [CGPoint]()
    var startEndAngle = [arcAngle]()
    var delegate: pieDelegate?
    var xAxisName:String?
    var otherViewsHeight:CGFloat = 0;
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        
        let width = self.frame.size.width;
        let height = self.frame.size.height-self.otherViewsHeight
        let centerX = width/2
        let centerY = height/2+self.titleView.frame.size.height+self.titleView.frame.origin.y;
        
        let radius = width < height ? (width/2) : (height/2)
        let innerRadius = radius * 0.6;
        
        
        if let currentContext = UIGraphicsGetCurrentContext(){
            
            CGContextClearRect(currentContext, rect)
            CGContextAddRect(currentContext, rect)
            CGContextSetRGBFillColor(currentContext,1.0,1.0,1.0,1.0)
            CGContextFillPath(currentContext)
            
            CGContextSetLineWidth(currentContext, radius-innerRadius)
            
            CGContextSaveGState(currentContext)
            let myShadowOffset = CGSizeMake (10, -5)
            CGContextSetShadow(currentContext, myShadowOffset, 5)
            
            CGContextSetRGBStrokeColor(currentContext,1.0,1.0,1.0,1.0)
            CGContextAddArc(currentContext,centerX,centerY,innerRadius+(radius-innerRadius)/2, radians(0),radians(360), 0)
            CGContextStrokePath(currentContext)
            
            CGContextRestoreGState(currentContext)
            
            
            var startAngle:CGFloat = 0, endAngle:CGFloat = 0;
            
            let diff:CGFloat = 0
            let angle = CGFloat(360 - CGFloat(self.colorKeys.count) * diff);
            
            var arcAngleTemp: arcAngle = arcAngle(startAngle: 0, endAngle: 0)
            
            for (colorIndex,colorKey) in self.colorKeys.enumerate()
            {
                if let chartUnit:ChartUnitData = self.data[colorKey]
                {
                    let angle = radians((chartUnit.value / total) * angle)
                    endAngle = startAngle + angle
                    
                    arcAngleTemp.startAngle = startAngle
                    arcAngleTemp.endAngle = endAngle
                    startEndAngle.append(arcAngleTemp)
                    
                    let index = colorIndex % colors.count
                    let color = colors[index];
                    
                    
                    CGContextSetStrokeColor(currentContext, CGColorGetComponents(color.CGColor))
                    CGContextAddArc(currentContext,centerX,centerY,innerRadius+(radius-innerRadius)/2, startAngle,endAngle, 0)
                    holdEndofArcPoints.append(CGContextGetPathCurrentPoint(currentContext))
                    CGContextStrokePath(currentContext)
                    
                    
                    startAngle = endAngle+radians(diff)
                }
                
            }
            
            
            
        }
        
        if(!isAnimated)
        {
            animate();
            isAnimated =  true;
        }
       
        
    }
    
   
    func animate()
    {
        let width = self.frame.size.width;
        let height = self.frame.size.height-self.otherViewsHeight
        let centerX = width/2
        let centerY = height/2+self.titleView.frame.size.height+self.titleView.frame.origin.y;
        
        let radius = width < height ? (width/2) : (height/2)
        let innerRadius = radius * 0.6;

        // Create the circle layer
        let circle = CAShapeLayer();
        
        
        
        // Set the center of the circle to be the center of the view
        let center = CGPointMake(centerX, centerY)
        
        let fractionOfCircle = 1.0;
        
        // The starting angle is given by the fraction of the circle that the point is at, divided by 2 * Pi and less
        // We subtract M_PI_2 to rotate the circle 90 degrees to make it more intuitive (i.e. like a clock face with zero at the top, 1/4 at RHS, 1/2 at bottom, etc.)
        let startAngle = radians(0)
        let endAngle = radians(360)
        let clockwise: Bool = false
        
        // `clockwise` tells the circle whether to animate in a clockwise or anti clockwise direction
        circle.path = UIBezierPath(arcCenter: center, radius: radius-innerRadius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).CGPath
        
        // Configure the circle
        circle.fillColor = UIColor.whiteColor().CGColor
        circle.strokeColor = UIColor.whiteColor().CGColor
        circle.lineWidth = radius+innerRadius;
        
        // When it gets to the end of its animation, leave it at 0% stroke filled
        circle.strokeEnd = 0.0
        
        // Add the circle to the parent layer
        self.layer.addSublayer(circle)
        
        // Configure the animation
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        drawAnimation.repeatCount = 1.0
        
        // Animate from the full stroke being drawn to none of the stroke being drawn
        drawAnimation.fromValue = NSNumber(double: fractionOfCircle)
        drawAnimation.toValue = NSNumber(float: 0.0)
        
        drawAnimation.duration = 1.0
        
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        // Add the animation to the circle
        circle.addAnimation(drawAnimation, forKey: "drawCircleAnimation")
        
        self.layer.addSublayer(circle);
    }
    
    
    init(frame: CGRect,data:[String:ChartUnitData],colorValues:[String],xAxisName:String,yAxisName:String) {
        
        self.xAxisName = xAxisName
        self.data = data;
        self.colorKeys = colorValues;
        
        for (_ , graphUnit ) in data
        {
            self.total = total+graphUnit.value;
            
        }
        
        legendView = LegendView.init(frame: CGRectZero, data: self.colorKeys,colors:colors);
        titleView = UILabel.init(frame: CGRectZero);
        titleView.textAlignment = NSTextAlignment.Center;
        titleView.text = xAxisName+" Vs "+yAxisName;
        
        super.init(frame: frame)
        self.addSubview(legendView)
        self.addSubview(titleView);
        
        let layer = CALayer.init();
        layer.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0).CGColor;
        layer.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1.0, CGRectGetWidth(self.frame), 1.0);
        
        self.layer.addSublayer(layer);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        legendView = LegendView.init(coder: aDecoder)!
        titleView = UILabel.init(coder: aDecoder)!
        self.data = [String:ChartUnitData]();
        self.colorKeys = [String]()
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        setSize()
        titleView.frame = CGRect(x:0, y:20, width:self.frame.size.width, height:50);
        let legendSpace:CGFloat = self.otherViewsHeight-self.titleView.frame.size.height-self.titleView.frame.origin.y-20;
        
        legendView.frame = CGRect(x:10, y:self.frame.size.height-legendSpace+5, width:self.frame.size.width-15, height:legendSpace-10);
        self.setNeedsDisplay()
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //let otherViewsHeight:CGFloat = 160;
        let width = self.frame.size.width
        let height = self.frame.size.height-otherViewsHeight
        let centerX = width/2
        let centerY = height/2+self.titleView.frame.size.height+self.titleView.frame.origin.y;
        var center: CGPoint = CGPoint()
        
        center.x = centerX
        center.y = centerY
        
        let radius = width < height ? (width/2) : (height/2)
        let innerRadius = radius * 0.6;
        
        for touch in touches {
            
            let touchLocation = touch.preciseLocationInView(self)
            let touchDistancefromCenterofThePoint = distanceWithCenter(touchLocation, centerX: centerX, centerY: centerY)
            
            if(touchDistancefromCenterofThePoint <= radius && touchDistancefromCenterofThePoint >= innerRadius) {
                
                let arcIndex: Int =  sectorIndex(touchLocation, centerX: center.x, centerY: center.y)!
                
                
                let colorKey = self.colorKeys[arcIndex]
                
                let unitData = self.data[colorKey]
                
                
                let storyboard = UIStoryboard(name: "Chart", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("popup") as UIViewController
                
                vc.modalPresentationStyle = UIModalPresentationStyle.Popover
                vc.preferredContentSize = CGSizeMake(self.popupWidth, self.popupHeight)
                vc.popoverPresentationController?.sourceRect = CGRect(x: touchLocation.x, y: touchLocation.y, width:0, height:0);
                vc.popoverPresentationController?.sourceView = self;
                
                let popupView:PopupView = vc.view as! PopupView;
                popupView.header1?.text = self.xAxisName
                popupView.header2?.text = unitData!.colorName;
                popupView.label1?.text = unitData!.xname;
                popupView.label2?.text = String(unitData!.value);
                
                let colorIndex = arcIndex % colors.count
                
                popupView.header1?.textColor = colors[colorIndex]
                popupView.header2?.textColor = colors[colorIndex]
                
                delegate?.showPopup(vc)
                
            }
        }
    }
    
    func distanceWithCenter(currentTouchPosition: CGPoint, centerX: CGFloat, centerY: CGFloat) -> CGFloat {
        let dx = currentTouchPosition.x -  centerX
        let dy = currentTouchPosition.y - centerY
        
        return sqrt(dx*dx + dy*dy)
    }
    
    func sectorIndex(touchLocation: CGPoint, centerX: CGFloat, centerY: CGFloat) -> Int? {
        
        var keyIndex: Int?
        
        let dy = touchLocation.y - centerY
        let dx = touchLocation.x - centerX
        
        var radians: CGFloat = atan2(dy, dx)
        
        if (radians < 0) {
            radians = CGFloat( 2 * M_PI) + radians;
        }
        
        for (key, value) in self.startEndAngle.enumerate() {
            let startAngle = value.startAngle
            let endAngle = value.endAngle
            
            if radians >= startAngle && radians <= endAngle {
                keyIndex = key
                break
            }
        }
        
        return keyIndex
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        self.otherViewsHeight = CGFloat(150);
        self.popupWidth =  CGFloat(300)
        self.popupHeight = CGFloat(60)
        titleView.font = UIFont.systemFontOfSize(CGFloat(10.0))
        
        if(deviceType == "ipad")
        {
            self.otherViewsHeight = CGFloat(300);
            
            self.popupWidth =  CGFloat(400)
            self.popupHeight = CGFloat(80)
            titleView.font = UIFont.systemFontOfSize(CGFloat(12.0))
        }
        
    }
    
    
    
}
