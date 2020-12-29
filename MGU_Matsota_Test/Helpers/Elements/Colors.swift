//
//  Colors.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

enum Colors {
    case navigationBarBackgroundColor
    case navigationTintColor
}

extension Colors {
    
    var value: UIColor {
        get {
            switch self {
            case .navigationBarBackgroundColor:
                return color("4D8EE2")
                
                
            case .navigationTintColor:
                return UIColor.white
            }
        }
    }
}

//MARK: - Private Methods
private extension Colors {
    
    func color(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
