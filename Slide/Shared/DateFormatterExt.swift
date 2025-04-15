//
//  DateFormatterExt.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import Foundation

extension DateFormatter {
    convenience init(type: DateFormatterType, locale: Locale = Locale(identifier: "ko_KR")) {
        self.init()
        self.dateFormat = type.rawValue
        self.locale = locale
    }
}
