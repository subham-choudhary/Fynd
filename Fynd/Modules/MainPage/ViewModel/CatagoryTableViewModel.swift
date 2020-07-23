//
//  CatagoryTableViewModel.swift
//  Fynd
//
//  Created by user178193 on 7/23/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation

protocol CatagoryTableProtocol {
    func getFilteredData(with filter: FilterType, data: [Product]) -> [Product]
}

class CatagoryTableViewModel: CatagoryTableProtocol {
    
    //Filtering data by FilterType
    func getFilteredData(with filter: FilterType, data: [Product]) -> [Product] {
        switch filter {
        case .name:
            return data.sorted { (a, b) -> Bool in
                a.name < b.name
            }
        case .price:
            return data.sorted { (a, b) -> Bool in
                a.cost < b.cost
            }
        }
    }
}
