//
//  MainView.swift
//  Slide
//
//  Created by hhhello0507 on 4/1/25.
//

import SwiftUI

enum MainDestination: Hashable {
    case newPost
}

struct MainView: View {
    @EnvironmentObject private var router: Router
    @State private var selection = 0
    
    var body: some View {
        MyBottomBar(selection: $selection) {
            HomeView()
                .page(.icon(.icon(.Home)))
            EmptyView()
                .page(.add)
            ProfileView()
                .page(.icon(.icon(.Person)))
        } addAction: {
            router.push(MainDestination.newPost)
        }
        .ignoresSafeArea(.keyboard)
        .navigationDestination(for: MainDestination.self) { path in
            switch path {
            case .newPost:
                NewPostView()
            }
        }
    }
}

#Preview {
    MainView()
}
