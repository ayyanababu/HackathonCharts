//
//  ProductCell.swift
//  MastGlobal11
//
//  Created by Raja Ayyan on 17/07/16.
//  Copyright © 2016 metricstream. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var prodImageView: UIImageView!
    @IBOutlet weak var prodTitle: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var descriptionview: UIButton!
    
    override func awakeFromNib() {
        layer.cornerRadius = 6.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(3.0, 3.0)
    }
    
    
    
    func configureCell(product: ProductModal, index: Int){
        
        self.prodImageView.image = UIImage(named: product.prodImage!)
        self.prodTitle.text = product.prodTitle
        self.descriptionview.tag = index
        
    }
}
