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
        let imageIndex = index % 6
        let imageFirstName = productCatagoryName.first?.lowercased() ?? ""
        let imageName = imageFirstName + "\(imageIndex)"
        return UIImage(imageLiteralResourceName: imageName)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
