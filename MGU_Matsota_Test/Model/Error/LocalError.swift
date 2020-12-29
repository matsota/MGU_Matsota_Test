//
//  LocalError.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import Foundation

enum LocalError: Error {
    
    case unknown
    case connection_lost
    
    case adults_only
    
    var localizedDescription: String {
        switch self {
        
        //MARK: - unknown
        case .unknown:
            debugPrint(comment)
            return NSLocalizedString("Невідома помилка", comment: comment)

        //MARK: - connection_lost
        case .connection_lost:
            debugPrint(comment)
            return NSLocalizedString("Немає зв'язку із сервером", comment: comment)
        
        //MARK: - adults_only
        case .adults_only:
            debugPrint(comment)
            return NSLocalizedString("Доступно лише для повнолітніх", comment: comment)
        }
    }
    
    //MARK: -
    private var comment: String {
        switch self {
        default: return "CUSTOM ERROR: LocalErrors: \(self)"
        }
    }
    
}
