//
//  CategoryNames.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation



struct Categories {
    let localizedDescription: String
    
    init(_ key: Keys) {
        switch  key {
        case .programmy_i_shou:
            localizedDescription = "Программы и шоу"
        }
    }
    
    enum Keys: String {
    
        case programmy_i_shou
    
    }
}

