//
//  String+Extensions.swift
//  Fynd
//
//  Created by user178193 on 7/24/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
