import SwiftUI

protocol AuthenticationSceneFactoryProtocol {
    func loginScene(_ feature: AuthenticationFeature, for route: LoginRoute) -> AnyView
}

final class AuthenticationSceneFactory: AuthenticationSceneFactoryProtocol {
    
    // MARK: - Dependencies
    private let loginAssembler: LoginAssembling
    
    // MARK: - Initialization
    
    init(loginAssembler: LoginAssembling) {
        self.loginAssembler = loginAssembler
    }
    
    // MARK: - Factory methods
    
    func loginScene(_ feature: AuthenticationFeature, for route: LoginRoute) -> AnyView {
        AnyView(loginAssembler.assemble(using: feature))
    }
}
