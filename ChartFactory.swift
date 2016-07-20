//
//  ChartFactory.swift
//  Dashboard
//
//  Created by administrator on 16/07/16.
//  Copyright © 2016 phani_mast_hack. All rights reserved.
//

import UIKit

protocol ChartFactoryProtocol {
    func createGraph(graph:ChartTypesEnum) -> (DisplayView)
}

enum ChartTypesEnum {
    case Line
    case Column
}

class ChartFactory: ChartFactoryProtocol {
    
    static let instance = ChartFactory()
    
    func createGraph(graph:ChartTypesEnum) -> (DisplayView)
    {
        switch graph
        {
        case .Line:
            return LinesDisplayView.init(frame: CGRectZero);
       
        default:
            return ColumnDisplayView.init(frame: CGRectZero);
        }
    }
}

