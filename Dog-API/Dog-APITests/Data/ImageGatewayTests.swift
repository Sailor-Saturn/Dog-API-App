import Foundation
import XCTest
@testable import Dog_API

final class ImageGatewayTests: XCTestCase {
    var networkSession: MockNetworkSession!
    var gateway: ImageGateway!
    
    override func setUp() {
        super.setUp()
        
        networkSession = MockNetworkSession()
        gateway = ImageGateway(networkSession: networkSession)
    }
    
    func test_WHEN_getAllDogs_request_is_called_THEN_the_response_is_correctly_created () {
        networkSession.data = imageResponse.data(using: .utf8)
        
        let fetchExpectation = expectation(description: "fetch expectation")

        var image: Image?
        var error: Error?

        gateway.getImage(completion: { result in
            if case .success(let imageResult) = result {
                image = imageResult
                
            } else if case .failure(let errorResult) = result {
                error = errorResult
            }

            fetchExpectation.fulfill()
        }, image: "BJa4kxc4X")
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(error)
    }
}
