////
////  public.swift
////  Slide
////
////  Created by hhhello0507 on 4/2/25.
////
//
//
//import Moya
//import Foundation
//
//public enum Authorization {
//    case none
//    case refresh
//}
//
///// MyTarget
///// Moya.TargetType을 추상화한 protocol
//public protocol MyTarget: TargetType {
//    var host: String { get }
//    var route: Route { get }
//    var authorization: Authorization { get }
//}
//
//public extension MyTarget {
//    
//    /**
//     Devide route
//     */
//    var baseURL: URL {
//        URL(string: "http://localhost:1234")!
//    }
//    
//    var path: String {
//        route.path
//    }
//    var method: Moya.Method {
//        route.method
//    }
//    var task: Moya.Task {
//        route.task
//    }
//    
//    /**
//     Just default value.
//     You can change another value.
//     */
//    var headers: [String: String]? {
//        ["Content-type": "application/json"]
//    }
//    var validationType: ValidationType {
//        .successCodes
//    }
//    var authorization: Authorization {
//        .refresh
//    }
//}
