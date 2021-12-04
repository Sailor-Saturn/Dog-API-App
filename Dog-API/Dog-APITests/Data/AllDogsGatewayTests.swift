
import Foundation
import XCTest
@testable import Dog_API

final class AllDogsGatewayTests: XCTestCase {
    var networkSession: MockNetworkSession!
    var gateway: AllDogsGateway!
    
    override func setUp() {
        super.setUp()
        
        networkSession = MockNetworkSession()
        gateway = AllDogsGateway(networkSession: networkSession)
    }
    
    func test_WHEN_getAllDogs_request_is_called_THEN_the_response_is_correctly_created () {
        networkSession.data = getAllDogsRequest.data(using: .utf8)
        
        let fetchExpectation = expectation(description: "fetch expectation")

        var allDogs: [Dog]?
        var error: Error?

        gateway.getAllDogs{ result in
            if case .success(let allDogsResult) = result {
                allDogs = allDogsResult
                
            } else if case .failure(let errorResult) = result {
                error = errorResult
            }

            fetchExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(error)
        XCTAssertEqual(allDogs?.count, 3)
        XCTAssertEqual(allDogs?[0].name, "Affenpinscher")
        XCTAssertEqual(allDogs?[0].bredFor, "Small rodent hunting, lapdog")
        XCTAssertEqual(allDogs?[0].breedGroup, "Toy")
        XCTAssertEqual(allDogs?[0].height.metric, "23 - 29")
        XCTAssertEqual(allDogs?[0].weight.metric, "3 - 6")
        XCTAssertEqual(allDogs?[0].lifeSpan, "10 - 12 years")
        XCTAssertEqual(allDogs?[0].temperament, "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving")
        XCTAssertEqual(allDogs?[0].origin, "Germany, France")
        XCTAssertEqual(allDogs?[0].image.url, "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg")
    }
}
