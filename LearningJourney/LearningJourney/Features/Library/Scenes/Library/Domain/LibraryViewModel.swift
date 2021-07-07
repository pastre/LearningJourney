import SwiftUI

protocol LibraryViewModelProtocol: ObservableObject {
    var strands: LibraryViewModelState<[LearningStrand]> { get }
    var searchQuery: String { get set }
    func handleOnAppear()
}

enum LibraryViewModelState<T: Equatable>: Equatable {
    case loading
    case error(ViewError)
    case result(T)
}

extension LibraryViewModelState: Identifiable where T == LearningObjective {
    var id: UUID { UUID() }
}

final class LibraryViewModel: LibraryViewModelProtocol {
    
    // MARK: - Inner types
    
    struct UseCases {
        let fetchStrandsUseCase: FetchStrandsUseCaseProtocol
    }
    
    // MARK: - ViewModel properties
    
    @Published private(set)
    var strands: LibraryViewModelState<[LearningStrand]> = .loading
    
    @Published
    var searchQuery: String = ""
    
    // MARK: - Dependencies
    
    private let useCases: UseCases
    
    // MARK: - Initialization
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }
    
    // MARK: - View Events
    
    func handleOnAppear() {
        strands = .loading
        useCases.fetchStrandsUseCase.execute { [weak self] in
            switch $0 {
            case let .success(strands):
                self?.strands = .result(strands)
            case let .failure(error):
                self?.handleError(error)
            }
        }
    }
    
    // MARK: - Helper functions
    
    private func handleError(_ error: LibraryRepositoryError) {
        switch error {
        case .unauthorized:
            self.strands = .error(.notAuthenticated)
        case .api, .parsing, .unknown:
            self.strands = .error(.unknown)
        }
    }
}
