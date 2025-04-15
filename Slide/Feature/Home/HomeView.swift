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
    @State private var selectedPost: Slide?
    
    var body: some View {
        VStack(spacing: 0) {
            header
            VTabView(selection: $selection) {
                ForEach(Array(Array(0..<100).enumerated()), id: \.offset) { index, element in
                    SlideCellView { action in
                        switch action {
                        case .commentTapped:
                            selectedPost
                        }
                    }
                    .task {
                        if index == 99 {
//                            do {
//                                try await viewModel.fetchPosts()
//                            } catch {
//                                print(error)
//                            }
                        }
                        print(index)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .task {
//            do {
//                try await viewModel.fetchPosts()
//            } catch {
//                print(error)
//            }
        }
        .sheet(item: $selectedPost) { post in
            CommentSheetView()
                .presentationDetents([.height(500), .large])
                .presentationCornerRadius(28)
        }
    }
    
    @ViewBuilder
    private var header: some View {
        HStack(spacing: 12) {
            Button {
                
            } label: {
                Text("추천")
                    .foregroundStyle(.label(.normal))
                    .myFont(.bodyM)
                    .padding(8)
            }
            .scaledButton()
            Button {
                
            } label: {
                Text("팔로우")
                    .foregroundStyle(.label(.normal).opacity(0.5))
                    .myFont(.bodyM)
                    .padding(8)
            }
            .scaledButton()
        }
        .padding(.top, 8)
    }
}

struct SlideCellView: View {
    @State private var selection = 0
    let action: (Self.Action) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selection) {
                PageCellView(text: "햇살 좋은 오후, 창밖으로 부드러운 바람이 커튼을 살짝살짝 흔들며 들어온다. 커피잔에서는 갓 내린 원두의 고소하고 따뜻한 향이 천천히 퍼져 나가고, 그 향에 마음도 조금은 느슨해진다. 주변은 고요하지만 머릿속은 끝없는 생각들로 가득하다—해야 할 일들, 하고 싶은 일들, 하지 말았어야 했던 것들까지. 창밖을 멍하니 바라보며 아무 생각 없이 있는 순간에도 어딘가 가슴 한켠엔 말랑한 설렘이 깃들고, 또 동시에 알 수 없는 불안이 스쳐 지나간다. 그래도 이런 날, 이유 없이 편안한 기분에 몸을 맡기며, 모든 게 잘 될 것만 같은 막연한 확신이 살짝 피어오른다.")
                PageCellView(text: "햇살 좋은 오후, 바람은 살랑이고 커피잔에서는 고소한 향이 피어오른다. 주변은 조용하지만 머릿속은 수많은 생각으로 분주하다. 이유 없는 설렘과 근거 없는 불안이 동시에 스쳐 지나가고, 그냥 그런 날에도 모든 게 괜찮을 것만 같은 기분이 든다.")
                PageCellView(text: "3")
                PageCellView(text: "4")
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            bottomBar
        }
    }
    
    @ViewBuilder
    private var sideBar: some View {
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
                action(.commentTapped)
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
            .scaledButton()
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
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    @ViewBuilder
    private var bottomBar: some View {
        HStack(spacing: 16) {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: ""))
                    .frame(width: 36, height: 36)
                    .clipShape(.circle)
                Text("nickname")
            }
            Spacer()
            HStack(spacing: 16) {
                Button {
                    
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "heart")
                            .foregroundStyle(.label(.normal))
                            .font(.title2)
                            .fontWeight(.regular)
                        Text("12.4k") // TODO: dummy
                            .foregroundStyle(.label(.normal))
                            .myFont(.labelM)
                    }
                }
                .scaledButton()
                Button {
                    action(.commentTapped)
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "message")
                            .foregroundStyle(.label(.normal))
                            .font(.title2)
                            .fontWeight(.regular)
                        Text("728") // TODO: dummy
                            .myFont(.labelM)
                    }
                }
                .scaledButton()
                Button {
                    
                } label: {
                    VStack(spacing: 0) {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.label(.normal))
                            .font(.title2)
                            .fontWeight(.regular)
                        Text("7k") // TODO: dummy
                            .myFont(.labelM)
                    }
                }
                .scaledButton()
            }
        }
        .padding(16)
    }
}

extension SlideCellView {
    enum Action {
        case commentTapped
    }
}

struct PageCellView: View {
    let text: String
    var body: some View {
        Text(text)
            .myFont(.bodyR)
            .foregroundStyle(.label(.normal))
            .lineSpacing(4)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(16)
    }
}

#Preview {
    HomeView()
}
