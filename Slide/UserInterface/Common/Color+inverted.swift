import SwiftUI

extension Color {
    /// 현재 색상의 반전된 색상을 반환하는 함수
    func inverted() -> Color {
        // UIColor 또는 NSColor로 변환
        #if os(iOS) || os(watchOS) || os(tvOS)
        typealias NativeColor = UIColor
        #else
        typealias NativeColor = NSColor
        #endif
        
        // SwiftUI Color → UIColor 또는 NSColor 변환
        guard let components = NativeColor(self).cgColor.components, components.count >= 3 else {
            return self // 변환 실패 시 원래 색상 반환
        }
        
        // RGB 값 반전 (알파 값 유지)
        let invertedColor = Color(
            red: 1.0 - components[0],
            green: 1.0 - components[1],
            blue: 1.0 - components[2],
            opacity: components.count > 3 ? components[3] : 1.0
        )
        
        return invertedColor
    }
}
