import XCTest

import TestingUtils
@testable import JLibrary
import SwiftUI

final class LibraryViewTests: XCTestCase {
    // MARK: - Properties
    private let shouldRecordSnapshotTests = false
    
    
    
    private let stub = LibraryViewModelStub()
    private lazy var sut = LibraryView(
        viewModel: stub,
        routingService: DummyRoutingService(),
        notificationCenter: NotificationCenter())
    private lazy var host = UIHostingController(rootView: sut)
    
    // MARK: - Snapshot tests
    
    func test_snapshot_whenLoading_properlyMatches() {
        // Given
        stub.strands = .loading
        stub.objectWillChange.send()
        _ = host.view
        
        // When / Then
        assertSnapshot(
            matching: host,
            as: .image(on: .iPhone8),
            record: shouldRecordSnapshotTests)
    }
    
    func test_snapshot_whenThereIsData_properlyMatches() {
        // Given
        stub.strands = .result(.init(
            repeating: .fixture(goals: .init(
                repeating: .fixture(),
                count: 10
            )),
            count: 10))
        stub.objectWillChange.send()
        _ = host.view
        
        // When / Then
        assertSnapshot(
            matching: host,
            as: .image(on: .iPhone8),
            record: shouldRecordSnapshotTests)
    }
    
    func test_snapshot_whenThereIsAnError_properlyMatches() {
        // Given
        stub.strands = .error(.unknown({ }))
        stub.objectWillChange.send()
        _ = host.view
        
        // When / Then
        assertSnapshot(
            matching: host,
            as: .image(on: .iPhone8),
            record: shouldRecordSnapshotTests)
    }
}

final class LibraryViewModelStub: LibraryViewModelProtocol {
    var strands: LibraryViewModelState<[LearningStrand]> = .loading
    
    var searchQuery: String = ""
    
    func handleOnAppear() {}
    
    func handleUserDidChange() {}
    
    func handleSignout() {}
}
