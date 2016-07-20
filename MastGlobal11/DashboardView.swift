//
//  DashboardView.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

protocol DashboardDelegate{
    func showPopup(viewController:UIViewController)
}

class DashBoardView: UIScrollView,ChartDelegate,pieDelegate {

    var charts:[UIView] = [UIView]();
    var dashboardDelegate:DashboardDelegate?
    var data:NSData?
    var inputX:[String]?
     var inputY:[String]?
    var filterDim:String?;
    
     var index = 0;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.whiteColor();
        
    }

    func applyFilter(filterVal:String)
    {
        for view in self.charts
        {
            view.removeFromSuperview();
        }
        
        drawDashBoard(self.data!,self.filterDim,filterVal,self.inputX!,self.inputY!);
        
    }
    
    func drawDashBoard(jsonData:NSData,_ filterDim:String?,_ filterVal:String?,_ inputX:[String], _ inputY:[String]) {
        
        var dimesions:[String] = [String]()
        var measures:[String] = [String]()
        var content:NSMutableDictionary?
        self.data = jsonData;
        self.inputX = inputX;
        self.inputY = inputY;
        self.filterDim = filterDim;
        
        do {
            let jsonDict = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary
            if let jsonDict:NSDictionary = jsonDict {
                // work with dictionary here
                if let structure = jsonDict["structure"] as? NSDictionary
                {
                    if let cells:NSArray = structure["types"] as? NSArray
                    {
                        
                        for colObj : AnyObject in cells {
                            if let cellObj = colObj as? NSDictionary {
                                
                                if let id:String = cellObj["id"] as? String
                                {
                                    if let value:String = cellObj["datatype"] as? String
                                    {
                                        if(value=="STRING")
                                        {
                                            dimesions.append(id);
                                        }else
                                        {
                                            measures.append(id);
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                if let contents = jsonDict["content"] as? NSDictionary
                {
                    content = NSMutableDictionary.init(dictionary: contents);
                }
                
                
                
            } else {
                // more error handling
            }
        } catch let error as NSError {
            // error handling
            NSLog("error %@", error.description);
        }
        
        if let data = content
        {
        
            
            var parser = Parser.init(jsonData: data, axisColumns: [self.inputX![0]]);
            
            
            if(index != 2)
            {
                let (columnData,columnAxisKeys,columnColorKeys) = parser.parseElements(measures,[self.inputY![0]],filterDim,filterVal);
                let columnChart = Chart.init(frame: CGRectZero, graph: ChartTypesEnum.Column,data:columnData,axisValues:columnAxisKeys,colorValues:columnColorKeys,xAxisName:"Product",yAxisName:"NO_OF_Views")
            
                columnChart.chartDelegate = self;
                self.addSubview(columnChart);
                charts.append(columnChart);
                
            }
            
        
            if(index == 3 )
            {
                parser = Parser.init(jsonData: data, axisColumns: [self.inputX![1]]);
                
                
            }
            
            if(index != 1)
            {
                let (columnDataLine,columnAxisKeysLine,columnColorKeysLine) = parser.parseElements(measures,[self.inputY![0]],filterDim,filterVal);
                let lineChart = Chart.init(frame: CGRectZero, graph: ChartTypesEnum.Line,data:columnDataLine,axisValues:columnAxisKeysLine,colorValues:columnColorKeysLine,xAxisName:"Product",yAxisName:"NO_OF_Views");
            
            
                lineChart.chartDelegate = self;
                self.addSubview(lineChart)
            
            
                charts.append(lineChart)
            }
            
            
            
            if(index != 3)
            {
            
    
            let (piedata,pieaxisKeys) = parser.parseElementsForPie(measures[0],filterDim,filterVal);
            
            let pieChart = PieChart.init(frame: CGRectZero,data:piedata,colorValues:pieaxisKeys,xAxisName:"Product",yAxisName:"Views");
            pieChart.delegate = self
            
            self.addSubview(pieChart)
            
            
            charts.append(pieChart)
            }
            
        }
    }

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        
        
        var width = self.frame.size.width;
        var height:CGFloat  = self.frame.size.height;
        
        self.contentSize  = CGSizeMake(width, height)
        
        var widthInc:CGFloat = 1.0;
        if(width > height)
        {
            width =  width/2;
            widthInc = 0.5;
            
        }else
        {
            height = height/2;
        }
        
        
        
        var indexW:CGFloat=0;
        var indexh:CGFloat=0;
        for view in self.charts
        {
            view.frame = CGRectMake(indexW * width, indexh * height, width, height);
            
            if( widthInc == 0.5 )
            {
                indexW = indexW + 1;
            }
            else
            {
                    indexh = indexh + 1;
            }
            
        }
    }
    
    func showPopup(viewController: UIViewController) {
        dashboardDelegate!.showPopup(viewController);
    }
}

