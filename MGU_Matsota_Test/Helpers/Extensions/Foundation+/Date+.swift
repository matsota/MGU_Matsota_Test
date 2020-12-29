//
//  Date+.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 29.12.2020.
//

import Foundation

//MARK: - Convertation
extension Date {
    
    /// - Transofrm date into single String with `MM-dd HH:mm`
    func MM_dd_HH_mm() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd HH:mm"
        return dateFormatter.string(from: self)
    }
    
    /// - Local date depends on `UTC`
    func localizeDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date()}
        
        return localDate
    }
    
}
