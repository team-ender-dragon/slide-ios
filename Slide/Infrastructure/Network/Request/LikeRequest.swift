struct LikeRequest: RequestProtocol {
    let targetId: Int
    let type: LikeType
}
