//
//  ContentView.swift
//  Slide
//
//  Created by hhhello0507 on 4/1/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var selection = 0
    @State private var selectedPost: Post?
    
    var body: some View {
        ZStack {
            VTabView(selection: $selection) {
                SlideCellView {
                    selectedPost
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack(spacing: 12) {
                Button {
                    
                } label: {
                    Text("추천")
                        .foregroundStyle(.label(.normal))
                        .myFont(.bodyM)
                        .padding(8)
                }
                .scaledButtonStyle()
                Button {
                    
                } label: {
                    Text("팔로우")
                        .foregroundStyle(.label(.normal).opacity(0.5))
                        .myFont(.bodyM)
                        .padding(8)
                }
                .scaledButtonStyle()
            }
            .padding(.top, 8)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            do {
                try await viewModel.fetchPosts()
            } catch {
                print(error)
            }
        }
    }
}

struct SlideCellView: View {
    let commentAction: () -> Void
    
    var body: some View {
        ZStack {
            TabView {
                PageCellView(text: "1")
                PageCellView(text: "2")
                PageCellView(text: "3")
                PageCellView(text: "4")
            }
            .tabViewStyle(.page)
            VStack(spacing: 24) {
                VStack(spacing: 8) {
                    Image(systemName: "heart")
                        .foregroundStyle(.label(.normal))
                        .font(.title2)
                        .fontWeight(.regular)
                    Text("12.4k") // TODO: dummy
                        .foregroundStyle(.label(.normal))
                        .myFont(.labelM)
                }
                Button {
                    commentAction()
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "message")
                            .foregroundStyle(.label(.normal))
                            .font(.title2)
                            .fontWeight(.regular)
                        Text("728") // TODO: dummy
                            .myFont(.labelM)
                    }
                }
                .scaledButtonStyle()
                VStack(spacing: 4) {
                    Image(systemName: "paperplane")
                        .foregroundStyle(.label(.normal))
                        .font(.title2)
                        .fontWeight(.regular)
                    Text("7k") // TODO: dummy
                        .myFont(.labelM)
                }
            }
            .padding(12)
            .padding(.bottom, 144)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            VStack {
                HStack {
                    Circle()
                        .fill(.fill)
                        .frame(width: 36, height: 36)
                    Text("nickname")
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

struct PageCellView: View {
    let text: String
    var body: some View {
        Text(text)
    }
}

#Preview {
    HomeView()
}
