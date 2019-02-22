//
//  Color-Management.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

let newListingColor = UIColor(rgb: 0x3BCDE2)
let healthyColor = UIColor(rgb: 0xFAFAFA)
let appliedColor = UIColor(rgb: 0xF43E5A)
let blackColor = UIColor(rgb: 0x141414)
let secondaryRedColor = UIColor(rgb: 0xC53747)
let lightGreyColor = UIColor(rgb: 0xBDBFC2)

