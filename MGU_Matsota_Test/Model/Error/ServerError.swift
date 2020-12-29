//
//  ServerError.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation

struct ServerError: Codable {
    let id: Int
    let message: String
    let error: Int
}
