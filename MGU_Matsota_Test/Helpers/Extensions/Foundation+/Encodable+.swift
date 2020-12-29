//
//  Encodable+.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation

extension Encodable {
    
    public var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
