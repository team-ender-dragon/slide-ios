import SwiftUI

public struct Wanted {
    public enum Weight: String, CaseIterable {
        case Black
        case Bold
        case ExtraBlack
        case ExtraBold
        case Medium
        case Regular
        case SemiBold
    }
    
    public static func register() {
        Wanted.Weight.allCases.forEach {
            guard let fontURL = Bundle.main.url(
                forResource: "WantedSans-\($0.rawValue)",
                withExtension: "otf"
            ),
                  let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else { return }
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterGraphicsFont(font, &error)
        }
    }
}
