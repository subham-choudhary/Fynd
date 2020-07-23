//
//  ProductTableViewCell.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    func configureCell(product: Product, index: Int, productCatagoryName: String) {
        productNameLabel.text = product.name
        productPriceLabel.text = String(describing: product.cost)
        productImageView.image = Utility.getImageFor(index: index, productCatagoryName: productCatagoryName)
    }
}
