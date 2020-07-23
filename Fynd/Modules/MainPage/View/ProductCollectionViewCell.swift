//
//  ProductCollectionViewCell.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func configureCell(product: Product) {
        productNameLabel.text = product.name
        productPriceLabel.text = String(describing: product.cost)
    }
}
