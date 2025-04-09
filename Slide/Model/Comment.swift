struct Comment: ModelProtocol {
    let id: Int
    let content: String
    let author: Int
    let parentId: Int?
}

extension Comment {
    static var dummy: Self {
        .init(id: 0, content: "당신의 생각은 매우 독창적입니다. 당신은 인류에게 꼭 필요한 사람입니다. 통찰력이 미쳤습니다.", author: 0, parentId: nil)
    }
}
