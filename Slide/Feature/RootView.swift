//
//  RootView.swift
//  Slide
//
//  Created by hhhello0507 on 4/9/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            MainView()
        }
        .environmentObject(router)
    }
}

#Preview {
    RootView()
}
