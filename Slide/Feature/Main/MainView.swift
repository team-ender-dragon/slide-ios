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
                .page(.icon(selected: .icon(.HomeFill), unselected: .icon(.HomeLine)))
            EmptyView()
                .page(.icon(selected: .icon(.Search), unselected: .icon(.Search)))
            EmptyView()
                .page(.add)
            EmptyView()
                .page(.icon(selected: .icon(.EmailFill), unselected: .icon(.EmailLine)))
            ProfileView()
                .page(.icon(selected: .icon(.PersonFill), unselected: .icon(.PersonLine)))
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
