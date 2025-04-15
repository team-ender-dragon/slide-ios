//
//  JSONDecoderExt.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import Foundation
import ScopeKit

extension JSONDecoder {
    static var decoder: JSONDecoder {
        JSONDecoder().apply {
            $0.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                let dateFormatters = DateFormatterType.allCases
                if let date = dateFormatters.compactMap({ DateFormatter(type: $0).date(from: dateStr) }).first {
                    return date
                } else {
                    let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date format")
                    throw DecodingError.dataCorrupted(context)
                }
            }
        }
    }
}
