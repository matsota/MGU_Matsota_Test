//
//  DemoRequest.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit

struct DemoRequest: Encodable {
    let borderId: Int
    let direction: Direction.RawValue
    let serial_number: String?
    
    init(_ borderId: Int, direction: Direction) {
        self.borderId = borderId
        self.direction = direction.rawValue
        serial_number = UIDevice.current.identifierForVendor?.uuidString
    }
    
    enum Direction: Int {
        case zero = 0
        case forward = 1
        case backward = -1
    }
}
