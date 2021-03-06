#if DEBUG

import SwiftUI
import CoreInjector

final class LibraryViewModelMock: LibraryViewModelProtocol {
    var isList: Bool = false
    
    func togglePresentationMode() {
        
    }
    
    func handleSignout() {
        
    }
    
    func handleUserDidChange() {
        
    }
    
    var searchQuery: String = ""
    
    let resultToUse: [LearningStrand]
    var strands: LibraryViewModelState<[LearningStrand]> = .loading
    
    init(resultToUse: [LearningStrand]) {
        self.resultToUse = resultToUse
    }
    
    func handleOnAppear() {
        strands = .result(resultToUse)
        objectWillChange.send()
    }
}

final class LibraryScenesFactoryMock: LibraryScenesFactoryProtocol {
    func resolveCreateObjectiveScene(for feature: LibraryFeature, route: Route?) -> AnyView {
        .init(Text("Dummy"))
    }
    
    func resolveCreateObjectiveScene(for feature: LibraryFeature) -> AnyView {
        .init(Text("Dummy"))
    }
    
    func resolveObjectivesListScene(for feature: LibraryFeature, using route: ObjectivesRoute) -> AnyView {
        .init(Text("Dummy"))
    }
    
    func resolveLibraryScene(for feature: LibraryFeature, using route: LibraryRoute?) -> AnyView {
        .init(Text("Dummy"))
    }
    
}

final class ObjectivesListViewModelMock: ObjectivesListViewModelProtocol {
    var goal: LearningGoal { .fixture() }
    
    @Published
    var objectives: LibraryViewModelState<[LearningObjective]> = .result([
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
        .fixture(),
    ])
    
    func handleWantToLearnToggled(objective state: LibraryViewModelState<LearningObjective>) {}
    
    func handleLearnStatusToggled(objective: LibraryViewModelState<LearningObjective>) {}
    
    var goalName: String = "Dummy"
    
    func handleOnAppear() {
        objectWillChange.send()
    }
}

#endif
