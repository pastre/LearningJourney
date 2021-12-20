import XCTest

@testable import CoreAnalytics

final class AnalyticsLoggerTests: XCTestCase {
    // MARK: - Properties
    
    private lazy var thirdPartyLoggerSpy = ThirdPartyLoggerSpy()
    
    // MARK: - Unit tests
    
    func test_log_whenHandlerHandlesDestination_itShouldNotLog() {
        // Given
        let eventStub = Event(destinations: [])
        let sut = buildSut()
        
        // When
        sut.log(event: eventStub)
        
        // Then
        XCTAssertEqual(thirdPartyLoggerSpy.logCallCount, 0)
    }
    
    func test_log_whenHandlerHandlesDestination_itShouldLog() {
        // Given
        let eventStub = Event(destinations: [.firebase])
        let sut = buildSut()
        
        // When
        sut.log(event: eventStub)
        
        // Then
        XCTAssertEqual(thirdPartyLoggerSpy.logCallCount, 1)
    }
    
    func test_defaultLoggers_properlyMatches() throws {
        // Given
        let sut = AnalyticsLogger()
        
        // When / Then
        let mirror = Mirror(reflecting: sut)
        let handlers = try XCTUnwrap(
            mirror.children.first(where: { $0.label == "handlers" })?.value
                as? [AnalyticsHandler]
        )
        
        XCTAssertTrue(handlers.first is FirebaseHandler)
    }
    
    // MARK: - Helpers
    private func buildSut(
        destination: AnalyticsDestination = .firebase,
        logger: ThirdPartyLogger? = nil
    ) -> AnalyticsLogger {
        
        let handlerSpy = AnalyticsHandlerSpyStub(
            destination: destination,
            logger: logger ?? thirdPartyLoggerSpy
        )
        
        let sut = AnalyticsLogger(handlers: [handlerSpy])
        
        return sut
    }
}

// MARK: - Stubs

struct AnalyticsHandlerSpyStub: AnalyticsHandler {
    let destination: AnalyticsDestination
    let logger: ThirdPartyLogger
}

final class ThirdPartyLoggerSpy: ThirdPartyLogger {
    
    private(set) var logCallCount = 0
    
    func log(event: AnalyticsPayload) {
        logCallCount += 1
    }
}

struct Event: AnalyticsEvent {
    var destinations: [AnalyticsDestination]
    var name: String = ""
    var properties: [AnalyticsProperty]? = nil
}
