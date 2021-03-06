import SwiftUI

import CoreNetworking

protocol ObjectivesListAssembling {
    func assemble(using feature: LibraryFeature, learningGoal: LearningGoal) -> AnyView
}

final class ObjectivesListAssembler: ObjectivesListAssembling{
    func assemble(using feature: LibraryFeature, learningGoal: LearningGoal) -> AnyView {
        let parser = LibraryParser()
        
        let service = LibraryRemoteService(
            apiFactory: feature.api)
        let repository = LibraryRepository(
            remoteService: service,
            parser: parser)
        let viewModel = ObjectivesListViewModel(
            useCases: .init(fetchObjectivesUseCase: FetchObjectivesUseCase(repository: repository)),
            dependencies: .init(goal: learningGoal),
            analyticsLogger: feature.analyticsLogger)
        
        let view = ObjectivesListView<ObjectivesListViewModel, ObjectiveCard>(
            routingService: feature.routingService,
            viewModel: viewModel
        ) {
            ObjectiveCard(viewModel: ObjectiveCardViewModel(
                useCases: .init(
                    toggleLearnUseCase: ToggleLearnUseCase(repository: repository),
                    toggleEagerToLearnUseCase: ToggleEagerToLearnUseCase(repository: repository),
                    updateObjectiveDescriptionUseCase: UpdateObjectiveDescriptionUseCase(repository: repository),
                    deleteObjectiveUseCase: DeleteObjectiveUseCase(repository: repository)),
                objective: $0,
                analyticsLogger: feature.analyticsLogger))
        }
        
        return AnyView(view)
    }
}
