//
//  CategoryCell.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 16/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    
    @IBOutlet weak var containerview: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryDescription: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerview.layer.cornerRadius = 5.0
//        self.containerview.layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        self.containerview.layer.shadowColor = UIColor.whiteColor().CGColor
        self.containerview.layer.shadowOpacity = 0.8
        self.containerview.layer.shadowRadius = 5.0
        self.containerview.layer.shadowOffset = CGSizeMake(2.0, 2.0)
        
        
        self.categoryImage.layer.cornerRadius = self.categoryImage.frame.size.width/2
        self.categoryImage.layer.borderWidth = 2.0
        self.categoryImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    
    
    func configureCell(category: CategoryModal){
        
        self.categoryImage.image = UIImage(named: category.categoryImage!)
        self.categoryTitle.text = category.categoryName
        self.categoryDescription.text = category.categoryDesc
     
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
