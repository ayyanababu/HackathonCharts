//
//  Chart.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

protocol ChartDelegate{
    func showPopup(viewController:UIViewController);
}

class Chart: UIView, DisplayViewDelegate{
    
    
    /*
     // Only override drawRect: if you perform customvarawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
    var startX:CGFloat = 0
    var startY:CGFloat = 0
    var legendSpace:CGFloat = 0
    let yaxis:YAxis,xaxis:XAxis,displayView:DisplayView,legendView:LegendView,titleView:UILabel
    let colors = ReadColorsBundle.instance.getColors()
    var chartDelegate:ChartDelegate?
    
    let xAxisKeys,colorKeys:[String]?
    
    init(frame: CGRect, graph: ChartTypesEnum,data:[String:[String:ChartUnitData]],axisValues:[String],colorValues:[String],xAxisName:String,yAxisName:String) {
        
        
        var high:CGFloat = 0.0;
        
        
        for (_ , values ) in data
        {
            
            for (_ , graphUnit ) in values
            {
                if( graphUnit.value > high)
                {
                    high = graphUnit.value
                }
                
            }
            
        }
        
        var remain = Int(high / 5)+1 ;
        
        if(remain%2==1)
        {
            remain = remain + 1;
        }
        
        high =  CGFloat (remain * 5);
        
        
        
        yaxis = YAxis.init(frame: CGRectZero, low: 0, high: high, units:5)
        xaxis = XAxis.init(frame: CGRectZero)
        
        displayView = ChartFactory.instance.createGraph(graph)
        
        
        titleView = UILabel.init(frame: CGRectZero);
        titleView.textAlignment = NSTextAlignment.Center;
        titleView.text = xAxisName+" Vs "+yAxisName;
        
        
        
        legendView = LegendView.init(frame: CGRectZero, data: colorValues,colors:colors);
         xAxisKeys = axisValues;
        colorKeys = colorValues;
        
        super.init(frame: frame)
        
        
        self.addSubview(xaxis);
        self.addSubview(yaxis);
        self.addSubview(displayView);
        self.addSubview(legendView);
        self.addSubview(titleView);
        
        setSize();
 
        displayView.data = data;
        displayView.highValue = high;
        displayView.lowValue = 0;
        displayView.xAxisKeys = axisValues;
        displayView.colorKeys = colorValues;
        displayView.showKeys = colorValues;
        displayView.xAxisName = xAxisName;
        
        displayView.delegate = self;
        
        xaxis.values = axisValues;
                
    }
    
    required init?(coder aDecoder: NSCoder) {
        yaxis = YAxis.init(coder: aDecoder)!
        xaxis = XAxis.init(coder: aDecoder)!
        displayView = DisplayView.init(coder: aDecoder)!
        legendView = LegendView.init(coder: aDecoder)!
        titleView = UILabel.init(coder: aDecoder)!
        xAxisKeys = [String]();
        colorKeys = [String]();
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        /* let startX:CGFloat = 80
         let startY:CGFloat = 75
         let legendSpace:CGFloat = 60 */
        
        /* let startX:CGFloat = 63
         let startY:CGFloat = 60
         let legendSpace:CGFloat = 50 */
        let deviceType = UIDevice.currentDevice()
        var xAxisHeight:CGFloat = 30;
        if(deviceType == "ipad")
        {
            xAxisHeight = 40;
        }
        
        let endX = self.frame.size.width - startX - 5
        let endY:CGFloat = self.frame.size.height-startY-xAxisHeight-legendSpace;
        
        titleView.frame = CGRect(x:0, y:20, width:self.frame.size.width, height:40);
        displayView.frame = CGRect(x: startX, y:startY, width:endX, height:endY)
        yaxis.frame = CGRect(x: 0, y:startY-8, width: startX, height:endY+16)
        xaxis.frame = CGRect(x:startX, y:startY+endY, width:endX, height:xAxisHeight)
        legendView.frame = CGRect(x:10, y:self.frame.size.height-legendSpace+5, width:self.frame.size.width-15, height:legendSpace-10);
        
        
//        let layer = CALayer.init();
//        layer.backgroundColor = UIColor.init(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0).CGColor;
//        layer.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1.0, CGRectGetWidth(self.frame), 1.0);
//        
//        self.layer.addSublayer(layer);
    }
    
    func showPopup(viewController: UIViewController) {
        chartDelegate!.showPopup(viewController);
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        
        
        var startX: Int = 37
        var startY: Int = 80
        var legendSpace: Int = 50
        titleView.font = UIFont.systemFontOfSize(CGFloat(10.0))
        
        if(deviceType == "ipad")
        {
             startX = 80
             startY = 75
             legendSpace = 100
             titleView.font = UIFont.systemFontOfSize(CGFloat(12.0));
        }
        
        self.startX = CGFloat(startX)
        self.startY = CGFloat(startY)
        self.legendSpace = CGFloat(legendSpace)
    }
    

}

