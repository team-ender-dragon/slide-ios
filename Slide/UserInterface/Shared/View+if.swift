//
//  View+content.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        then trueTransform: (Self) -> Content,
        else falseTransform: (Self) -> Content
    ) -> some View {
        if condition {
            trueTransform(self)
        } else {
            falseTransform(self)
        }
    }
}
