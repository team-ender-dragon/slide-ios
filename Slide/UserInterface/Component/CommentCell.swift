//
//  CommentCell.swift
//  Slide
//
//  Created by hhhello0507 on 4/2/25.
//

import SwiftUI

struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        Text(comment.content)
            .myFont(.bodyM)
    }
}

#Preview {
    CommentCell(comment: .dummy)
}
