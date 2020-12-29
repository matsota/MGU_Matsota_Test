//
//  AlertConfiguration.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

struct AlertConfiguration {
    let alertTitle: String
    let alertBody: String
    let color: UIColor?
    
    init (_ alertBody: String, _ color: UIColor?, _ alertTitle: String = "Внимание") {
        self.alertTitle = alertTitle
        self.alertBody = alertBody
        self.color = color
    }
    
}
