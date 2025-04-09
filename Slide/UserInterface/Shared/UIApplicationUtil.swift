#if canImport(UIKit)
import UIKit

public enum UIApplicationUtil {
    public static var scenes: Set<UIScene> {
        return UIApplication.shared.connectedScenes
    }
    
    public static var windowScene: UIWindowScene? {
        return Self.scenes.compactMap({ $0 as? UIWindowScene }).first
    }
    
    public static var window: UIWindow? {
        return Self.windowScene?.windows.first
    }
    
    public static var safeAreaInsets: UIEdgeInsets? {
        return Self.window?.safeAreaInsets
    }
    
    public static var rootViewController: UIViewController? {
        return Self.window?.rootViewController
    }
}
#endif
