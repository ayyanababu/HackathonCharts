//
//  File.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

class Parser: NSObject {
    
    var jsonData:NSDictionary
    var axisColumns:[String]
    
    init(jsonData: NSDictionary, axisColumns:[String]) {
        
        self.jsonData = jsonData
        self.axisColumns = axisColumns
        super.init()
    }
    
    func parseElements(measures:[String],_ colorDimensions:[String], _ filterDim:String?,_ filterVal:String?) -> ([String:[String:ChartUnitData]],[String],[String])
    {
        var data:[String:[String:ChartUnitData]] = [String:[String:ChartUnitData]]()
        var axisKeys:[String] = [String]()
        var colorKeys:[String] = [String]()
        
        if let rows:NSArray = self.jsonData["rows"]as? NSArray
        {
            for obj : AnyObject in rows {
                
                if let rowObject = obj as? NSDictionary
                {
                    var cell = [String:String]()
                    if let cells = rowObject["cells"] as? NSArray {
                        
                        for colObj : AnyObject in cells {
                            if let cellObj = colObj as? NSDictionary {
                                
                                if let id:String = cellObj["id"] as? String
                                {
                                    if let value:String = cellObj["value"] as? String
                                    {
                                        cell[id] = value;
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    var axisValue="";
                    
                    
                    if let filterDimension:String = filterDim
                    {
                        if(filterDimension == "email" )
                        {
                            if(filterVal == "Anonymus"  && "" != cell[filterDimension])
                            {
                                continue;
                            }else if(filterVal == "Logged_in"  && "" == cell[filterDimension])
                            {
                                continue;
                            }
                            
                        }else if let dimValue = cell[filterDimension] where dimValue != filterVal
                        {
                            continue;
                        }
                    }
                    
                    for(axisKey) in axisColumns
                    {
                        if(cell[axisKey] == nil)
                        {
                            continue;
                        }
                        
                        axisValue += cell[axisKey]!;
                    }
                    
                    if(axisValue == "" || axisValue == "nil")
                    {
                        continue;
                    }
                    
                    var colorName = "";
                    
                    for(axisKey) in colorDimensions
                    {
                        
                        if(cell[axisKey] == nil)
                        {
                            continue;
                        }
                        colorName += cell[axisKey]!;
                    }
                    
                    
                    if(!axisKeys.contains(axisValue))
                    {
                        axisKeys.append(axisValue);
                        var arryValues = [String:ChartUnitData]()
                        for(clrName) in measures
                        {
                            let stringValue:String = cell[clrName]!
                            let value = CGFloat((stringValue as NSString).doubleValue)
                            
                            if(colorDimensions.count == 0)
                            {
                                colorName = clrName;
                                
                            }else if(measures.count>1)
                            {
                                colorName = colorName + "-" + clrName;
                            }
                            
                            if(colorName == "" || colorName == "nil")
                            {
                                continue;
                            }
                            
                            if(!colorKeys.contains(colorName))
                            {
                                colorKeys.append(colorName);
                            }
                            
                            let graphUnit = ChartUnitData.init(xname: axisValue, colorName:colorName, value: value);
                            arryValues[colorName] = graphUnit
                        }
                        
                        data[axisValue] = arryValues;
                        
                    }else
                    {
                        var arryValues:[String:ChartUnitData] = data[axisValue]!;
                        for(clrName) in measures
                        {
                        
                            
                            let stringValue:String = cell[clrName]!
                            let value = CGFloat((stringValue as NSString).doubleValue)
                            
                            
                            if(colorDimensions.count == 0)
                            {
                                colorName = clrName;
                                
                            }else if(measures.count>1)
                            {
                                colorName = colorName + "-" + clrName;
                            }
                            
                            if(colorName == "" || colorName == "nil")
                            {
                                continue;
                            }
                            
                            if(!colorKeys.contains(colorName))
                            {
                                colorKeys.append(colorName);
                            }
                            
                            if let graphUnit = arryValues[colorName]
                            {
                                graphUnit.value += value;
                                
                            }else
                            {
                                let graphUnit = ChartUnitData.init(xname: axisValue, colorName:colorName, value: value);
                                arryValues[colorName] = graphUnit
                            }
                            
                        }
                        
                        data[axisValue] = arryValues;
                        
                    }
                    
                }
                
            }
        }
        
        return (data,axisKeys,colorKeys)
        
    }
    
    func parseElementsForPie(colorName:String,_ filterDim:String?,_ filterVal:String?) -> ([String:ChartUnitData],[String])
    {
        
        var pieData:[String:ChartUnitData] = [String:ChartUnitData]();
        var axisKeys:[String] = [String]()
        
        if let rows:NSArray = self.jsonData["rows"]as? NSArray
        {
            for obj : AnyObject in rows {
                
                if let rowObject = obj as? NSDictionary
                {
                    var cell = [String:String]()
                    if let cells = rowObject["cells"] as? NSArray {
                        
                        for colObj : AnyObject in cells {
                            if let cellObj = colObj as? NSDictionary {
                                
                                if let id:String = cellObj["id"] as? String
                                {
                                    if let value:String = cellObj["value"] as? String
                                    {
                                        cell[id] = value;
                                        
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                    if let filterDimension:String = filterDim
                    {
                        if let dimValue = cell[filterDimension] where dimValue != filterVal
                        {
                            continue;
                        }
                    }
                    
                    var axisValue="";
                    
                    for(axisKey) in axisColumns
                    {
                        axisValue += cell[axisKey]!;
                    }
                    
                    
                    if(!axisKeys.contains(axisValue))
                    {
                        axisKeys.append(axisValue);
                        
                        
                        let stringValue:String = cell[colorName]!
                        let value = CGFloat((stringValue as NSString).doubleValue)
                        let graphUnit = ChartUnitData.init(xname: axisValue, colorName:colorName, value: value);
                        pieData[axisValue] = graphUnit;
                        
                    }else
                    {
                        let graphUnit:ChartUnitData = pieData[axisValue]!;
                        let stringValue:String = cell[colorName]!
                        let value = CGFloat((stringValue as NSString).doubleValue)
                        graphUnit.value += value;
                        
                    }
                    
                }
                
            }
        }
        
        return (pieData,axisKeys);
        
    }
    
}
