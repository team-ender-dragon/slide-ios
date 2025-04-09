//
//  HomeFeature.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var posts: [Post]?
    
    func fetchPosts() async throws {
//        let response = try await PostService.shared.get()
//        self.posts = posts
    }
}
