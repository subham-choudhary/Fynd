//
//  HeaderProtocol.swift
//  Fynd
//
//  Created by user178193 on 7/23/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation

protocol HeaderProtocol: AnyObject {
    func didTapFilter(section:Int, selectedFilterType: FilterType)
    func didExpandOn(section: Int)
}
