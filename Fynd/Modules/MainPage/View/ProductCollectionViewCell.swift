//
//  ProductCollectionViewCell.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    //MARK:- IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    
    //MARK:- CustomFunctions
    func configureCell(product: Product) {
        productImageView.image = Utility.getImageFor(index: product.sku, productCatagoryName: product.name)
    }
}
