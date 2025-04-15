//
//  JSONEncoderExt.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import Foundation
import ScopeKit

extension JSONEncoder {
    static var encoder: JSONEncoder {
        JSONEncoder().apply {
            $0.dateEncodingStrategy = .custom { date, encoder in
                let dateStr = DateFormatter(type: .isoDateTimeMilliSec).string(from: date)
                var container = encoder.singleValueContainer()
                try container.encode(dateStr)
            }
        }
    }
}
