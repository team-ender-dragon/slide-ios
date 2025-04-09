////
////  PostTarget.swift
////  Slide
////
////  Created by hhhello0507 on 4/2/25.
////
//
//import Foundation
//
//enum PostTarget: MyTarget {
//    case get
//    
//    var host: String {
//        ""
//    }
//    
//    var route: Route {
//        switch self {
//        case .get:
//                .get()
//        }
//    }
//}
//
//class PostService {
//    static let shared = PostService()
//    
//    func get() async throws -> [Post] {
//        try await runner.request(PostTarget.get, res: [Post].self)
//    }
//}
