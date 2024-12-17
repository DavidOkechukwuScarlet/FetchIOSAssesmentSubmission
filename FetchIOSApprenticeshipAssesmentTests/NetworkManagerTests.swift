//
//  NetworkManagerTests.swift
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//
import XCTest
@testable import FetchIOSApprenticeshipAssesment  // Replace with the name of your app module

class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager.shared
    }

    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }

    // Test with real network call
    func testGetRecipess_validData() async throws {
        let recipeURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"

        // Call the method under test
        do {
            let Recipes = try await networkManager.getRecipes(recipeEndPoint: recipeURL)
            // Ensure the response contains the expected data
            XCTAssertGreaterThan(Recipes.count, 0, "Expected to receive at least one recipe.")
            XCTAssertNotNil(Recipes.first?.name, "Recipes should have a name.")
        } catch {
            XCTFail("Expected successful response, but failed with error: \(error)")
        }
    }
    // Test with empty response
    func testGetRecipess_emptyData() async throws {
        // Make sure to use the "empty" URL in your tests, assuming you have a specific endpoint that returns an empty response.
        let emptyURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        guard let url = URL(string: emptyURL) else {
            XCTFail("Invalid URL")
            return
        }
        
        // Change the URL dynamically if needed for the test case
        networkManager = NetworkManager.shared
        let response = try await networkManager.getRecipes(recipeEndPoint: emptyURL)
        
        XCTAssertEqual(response.count, 0, "Expected an empty response but got \(response.count) Recipess.")
    }

    // Test error case with malformed data
    func testGetRecipess_malformedData() async throws {
        let malformedURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
        guard let url = URL(string: malformedURL) else {
            XCTFail("Invalid URL")
            return
        }
        
        do {
            let _ = try await networkManager.getRecipes(recipeEndPoint: malformedURL)
            XCTFail("Expected an error due to malformed data but got a successful response.")
        } catch {
            XCTAssertTrue(error is APError, "Expected an APError but got \(error).")
        }
    }
}
