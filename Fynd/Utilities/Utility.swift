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
    
    private static let spinner = UIActivityIndicatorView()
    
    class func startSpinner(presentingView: UIView) {
        DispatchQueue.main.async {
            spinner.hidesWhenStopped = true
            spinner.style = .medium
            spinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            spinner.frame = CGRect(x:presentingView.bounds.size.width / 2, y:presentingView.bounds.size.height / 2, width:40, height: 40)
            spinner.center = CGPoint(x: presentingView.bounds.size.width / 2, y: presentingView.bounds.size.height / 2)
            spinner.tag = 007
            spinner.startAnimating()
            presentingView.addSubview(spinner)
        }
    }
    
    class func stopSpinner(presentingView: UIView){
        DispatchQueue.main.async {
            presentingView.viewWithTag(007)?.removeFromSuperview()
        }
    }
    
    class func getImageFor(index:Int, productCatagoryName: String) -> UIImage {
        let imageIndex = index % 6
        let imageFirstName = productCatagoryName.first?.lowercased() ?? ""
        let imageName = imageFirstName + "\(imageIndex)"
        return UIImage(imageLiteralResourceName: imageName)
    }
    
}


