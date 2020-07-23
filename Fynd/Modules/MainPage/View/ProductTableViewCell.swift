//
//  ProductTableViewCell.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    //MARK:- CustomFunctions
    func configureCell(product: Product) {
        productNameLabel.text = product.name.capitalizingFirstLetter()
        productPriceLabel.text = getEditedCost(from: product.cost)
        productImageView.image = Utility.getImageFor(index: product.sku, productCatagoryName: product.name)
    }
    
    func getEditedCost(from value: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value: value)) {
            return "₹ \(formattedNumber)"
        } else {
            return "₹ \(value)"
        }
    }
}
