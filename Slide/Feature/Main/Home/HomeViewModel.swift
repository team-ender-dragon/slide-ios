import Foundation
import Combine

class HomeViewModel: ObservableObject {
    static let pagingInterval = 50
    
    @Published var slides: [Slide]?
    @Inject(\.slideService) var slideService
    var subscriptions = Set<AnyCancellable>()
    
    func getSlides() {
        let publisher = slideService.getSlides(request: .init(amount: Self.pagingInterval))
            .catchToEmpty()
            .map { $0.map { $0.toModel() } }
        
        if slides == nil {
            publisher
                .map(Optional.some)
                .assign(to: &$slides)
        } else {
            publisher
                .sink { newValue in
                    self.slides?.append(contentsOf: newValue)
                }
                .store(in: &subscriptions)
        }
    }
}
