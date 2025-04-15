import SwiftUI
import UIKit

extension View {
    func hideKeyboardWhenTap() -> some View {
        self.onTapGesture(perform: hideKeyboard)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication {
    func hideKeyboard() {
        guard let window = UIApplicationUtil.window else { return }
        
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing)).apply {
            $0.cancelsTouchesInView = false
            $0.delegate = self
        }
        
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: @retroactive UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return false
    }
}
