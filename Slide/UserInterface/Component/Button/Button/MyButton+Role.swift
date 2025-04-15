import SwiftUI

public extension MyButton {
    enum Role: Hashable, CaseIterable {
        case primary
        case assistive
        
        var properties: Self.Properties {
            switch self {
            case .primary:
                    .init(
                        foreground: .primary(.onPrimary),
                        background: .primary(.normal)
                    )
            case .assistive:
                    .init(
                        foreground: .label(.neutral),
                        background: .fill(.neutral)
                    )
            }
        }
    }
}

extension MyButton.Role {
    struct Properties {
        let foreground: Color
        let background: Color
    }
}
