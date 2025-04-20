import SwiftUI

final class Router: ObservableObject {
    @Published public var path = NavigationPath()
}

extension Router {
    func push(_ view: NavGroup) {
        self.path.append(view)
    }
    
    func pop() {
        if !self.path.isEmpty {
            self.path.removeLast()
        }
    }
    
    func toRoot() {
        self.path.removeLast(self.path.count)
    }
    
    func replace(_ views: [NavGroup]) {
        toRoot()
        views.forEach {
            push($0)
        }
    }
}
