//
//  DemoResponse.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation

struct DemoResponse: Codable {
    
    let category_name: String
    let items: [Item]
    
    
    struct Item: Codable {
        let id: Int
        let stop_ts: Int
        let icon: String
        let name: String
        let start_ts: Int
        let channel_name: String
        let description: String
    }
}
