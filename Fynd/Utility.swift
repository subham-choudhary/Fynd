//
//  Utility.swift
//  Fynd
//
//  Created by user178193 on 7/23/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation
import UIKit


class Utility {
    
    static func getImageFor(index:Int, productCatagoryName: String) -> UIImage {
        let imageIndex = index % 8
        let imageFirstName = productCatagoryName.first?.lowercased() ?? ""
        let imageName = imageFirstName + "\(imageIndex)"
        return UIImage(imageLiteralResourceName: imageName)
    }
}
