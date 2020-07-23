//
//  ProductListModel.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation


struct ProductCatagory: Codable {
    let name: String
    let products:[Product]
}

struct Product: Codable {
    let sku: Int
    let name: String
    let cost: Int
}
