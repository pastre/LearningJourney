import XCTest
import TestingUtils

@testable import JLibrary

final class LearningGoalCardTests: XCTestCase {
    // MARK: - Properties
    
    private let shouldRecordSnapshots = false
    
    // MARK: - Snapshot tests
    
    func test_snapshot_whenNoProgress() {
        let sut = LearningGoalCard(goal: .fixture(progress: 0))
        assertSnapshot(
            matching: sut,
            as: .image,
        record: shouldRecordSnapshots)
    }
    
    func test_snapshot_whenHalfProgress() {
        let sut = LearningGoalCard(goal: .fixture(progress: 0.5))
        assertSnapshot(
            matching: sut,
            as: .image,
        record: shouldRecordSnapshots)
    }
    
    func test_snapshot_whenFullProgress() {
        let sut = LearningGoalCard(goal: .fixture(progress: 1))
        assertSnapshot(
            matching: sut,
            as: .image,
        record: shouldRecordSnapshots)
    }
}
