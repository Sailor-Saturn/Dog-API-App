
import Foundation
import XCTest

@testable import Dog_API

final class GetAllDogsRequestTests: XCTestCase {
    func test_WHEN_GET_All_Launches_request_is_made_then_the_URL_is_correctly_built () {
        let request = GetAllDogsRequest()
        
        XCTAssertEqual(request.url.absoluteString, "https://api.thedogapi.com/v1/breeds")
        XCTAssertEqual(request.urlRequest.httpMethod, "GET")
        
    }
}
