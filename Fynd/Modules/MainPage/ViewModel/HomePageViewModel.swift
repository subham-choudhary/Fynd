//
//  HomePageViewModel.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation

enum ViewStyle {
    case grouped
    case list
}

enum FilterType: Int {
    case name = 0
    case price = 1
}

protocol HomePageProtocol {
    var onSuccess: ([ProductCatagory]) -> Void { get set }
    var onFaliure: (Error) -> Void { get set }
    var addRemoveLoader : (Bool) -> Void { get set }
    func getAllDataFromApi()
    
}

class HomePageViewModel : HomePageProtocol {
    
    var onSuccess: ([ProductCatagory]) -> Void = {_ in}
    var onFaliure: (Error) -> Void = {_ in}
    var addRemoveLoader : (Bool) -> Void = {_ in}
    
    func getAllDataFromApi() {
        let request = GetAllDataRequest()
        
        APIClient().fetchData(apiRequest: request) { (result: Result<[ProductCatagory]?,Error>) in
            switch result {
            case .success(let model):
                self.groupSimilarCatagoryTogether(model ?? [])
            case .failure(let error):
                self.onFaliure(error)
            }
        }
    }
    //Grouping catagory with same name together.
    func groupSimilarCatagoryTogether(_ data: [ProductCatagory]) {
        let filteredData = data.filter({$0.products.count > 0})
        var catagoryDict: [String:ProductCatagory] = [:]
        for catagory in filteredData {
            if let catag = catagoryDict[catagory.name] {
                let catagProducts = catag.products + catagory.products
                let newProductCatagory = ProductCatagory(name: catagory.name, products: catagProducts)
                catagoryDict[catagory.name] = newProductCatagory
            } else {
                catagoryDict[catagory.name] = catagory
            }
        }
        self.onSuccess(catagoryDict.map { $0.value })
    }
}
