//
//  Legend.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

class LegendView: UIView{
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.

    
    var labelHeight:CGFloat = 0;
    var labelWidth:CGFloat = 0;
    var cirlceMeasure:CGFloat = 0;
    
    //space between legend values
    var horizSpace:CGFloat = 0;
    var verticalSpace:CGFloat = 0;
    
    var radius:CGFloat = 0;
    
    var fontSize: CGFloat = 0
    
    
    var maxColumn: Int?
    var maxRows: Int?
    var startX: CGFloat?
    var maxlabelwidth: CGFloat?
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        setSize()
        
        if(self.values.count<1){
            return;
        }
        
        let height = rect.size.height;
        let width = rect.size.width;
        
        if let currentContext = UIGraphicsGetCurrentContext(){
            CGContextClearRect(currentContext, rect)
            CGContextAddRect(currentContext, rect)
            CGContextSetRGBFillColor(currentContext,1.0,1.0,1.0,1.0)
            //CGContextSetRGBFillColor(currentContext,0.0,1.0,1.0,1.0)
            CGContextFillPath(currentContext)
            
            let centerX = cirlceMeasure/2;
            let centerY = cirlceMeasure/2;
            
            let cirlceWidth = cirlceMeasure+4;
            
            var sum = 0;
            
            for (_, value) in self.values.enumerate()
            {
                sum = sum+value.characters.count;
            }
            
            let maxAvg = sum/self.values.count+1;
            
            labelWidth = cirlceWidth + CGFloat(maxAvg * 10);
            maxlabelwidth = labelWidth
            
            // no of columns needed
            maxColumn = Int(width / (labelWidth+horizSpace));
            
            if(0 == maxColumn)
            {
                maxColumn = 1;
            }
            // maximumColoumns = maxColumn
            
            startX = 0;
            
            if maxColumn < self.values.count
            {
                startX = (width - (labelWidth+horizSpace)*CGFloat(maxColumn!)+horizSpace)/2 ;
                
            }else
            {
                startX = (width - (labelWidth+horizSpace)*CGFloat(self.values.count)+horizSpace)/2
            }
            //startXVal = startX
            
            
            // no of rows needed
            maxRows = Int (height / (verticalSpace+labelHeight));
            // maximumRows = maxRows
            
            let rows:Int = Int((self.values.count/maxColumn!)+1);
            
            if (maxRows > rows)
            {
                maxRows = rows;
            }
            
            for (index, value) in self.values.enumerate()
            {
                
                let currentCol = Int(index%maxColumn!);
                let currentRow = Int(index/maxColumn!);
                
                if (currentRow >= maxRows) {break;}
                
                
                
                let labelX =  CGFloat(currentCol) * (labelWidth+horizSpace);
                let labelY = CGFloat(currentRow) * (labelHeight+verticalSpace);
                
                
                CGContextSaveGState(currentContext);
                
                let labelRect:CGRect = CGRectMake(startX! + labelX+cirlceWidth,labelY,labelWidth-cirlceWidth,labelHeight);
                let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle.init();
                paragraphStyle.lineBreakMode = NSLineBreakMode.ByTruncatingTail;
                paragraphStyle.alignment = NSTextAlignment.Left;
                
                let colorIndex = index % colors.count
                
                
                let legendLabelColor = colors[colorIndex]
                
                
                
                //Ashok: Legend View Font Value Changed
                let attrs = [NSFontAttributeName: UIFont.systemFontOfSize(self.fontSize), NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: legendLabelColor];
                
                value.drawInRect(labelRect, withAttributes: attrs);
                
                CGContextRestoreGState(currentContext);
                CGContextSetStrokeColor(currentContext, CGColorGetComponents(colors[colorIndex].CGColor))
                CGContextSetFillColor(currentContext, CGColorGetComponents(colors[colorIndex].CGColor))
                
                CGContextAddArc(currentContext,startX!+labelX+centerX,labelY+centerY,radius, radians(0),radians(359.9), 0)
                CGContextClosePath(currentContext);
                CGContextFillPath(currentContext);
                
            }
            
            
        }
    }
    
    
    var values: [String]
    let colors:[UIColor]
    
    init(frame: CGRect, data:[String],colors:[UIColor]) {
        
        self.values = data;
        self.colors = colors;
        super.init(frame: frame)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        self.values = [String]()
        self.colors = [UIColor]()
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        self.setNeedsDisplay();
    }
    
    func setSize() {
        
        let deviceType = UIDevice.currentDevice()
        
        self.radius = CGFloat(4)
        self.horizSpace = CGFloat(0)
        self.verticalSpace = CGFloat(5)
        self.cirlceMeasure = CGFloat(11)
        self.labelHeight = CGFloat(14)
        self.labelWidth = CGFloat(14)
        self.fontSize = CGFloat(9)
        
        if(deviceType == "ipad")
        {
            self.radius = CGFloat(6)
            self.horizSpace = CGFloat(10)
            self.verticalSpace = CGFloat(10)
            self.cirlceMeasure = CGFloat(16)
            self.labelHeight = CGFloat(20)
            self.labelWidth = CGFloat(20)
            self.fontSize = CGFloat(12)
        }
    }
    
}
