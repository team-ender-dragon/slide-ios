import SwiftUI

struct ListCell: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(title)
                    .myFont(.bodyM)
                    .foregroundStyle(.label(.normal))
                Spacer()
                Image.icon(.ExpandArrow)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.label(.assistive))
                    .rotationEffect(.degrees(180))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scaledButton()
    }
}
