//
//  Recipe.swift
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//

import Foundation

// Recipe struct that conforms to both Decodable and Identifiable
struct Recipe: Decodable, Identifiable {
    let id: String          // The id field is a string, as per your table
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let sourceURL: String?
    let youtubeURL: String?

    // Define the coding keys to map the JSON keys to the property names
    enum CodingKeys: String, CodingKey {
        case id = "uuid"         // Map 'uuid' from JSON to 'id' for Identifiable
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}


struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

struct MockData {
    static let sampleRecipe = Recipe(      id: "1",
                                           cuisine: "Chinsese", name: "Abc",
                                           photoURLLarge: "food-placeholder",
                                           photoURLSmall: "food-placeholder",
                                           sourceURL: "https://some.url/index.html",
                                           youtubeURL: "https://www.youtube.com/watch?v=some.id"
                                           )
    
    static let recipes = [sampleRecipe, sampleRecipe, sampleRecipe, sampleRecipe]
    
    static let orderItem1 = Recipe(        id: "2",
                                           cuisine: "Indian", name: "Abc",
                                           photoURLLarge: "food-placeholder",
                                           photoURLSmall: "food-placeholder",
                                           sourceURL: "https://some.url/index.html",
                                           youtubeURL: "https://www.youtube.com/watch?v=some.id"
                                           )
    
    static let orderItem2 = Recipe(         id: "3",
                                            cuisine: "American",
                                            name: "Abc",
                                            photoURLLarge: "food-placeholder",
                                            photoURLSmall: "food-placeholder",
                                           sourceURL: "https://some.url/index.html",
                                           youtubeURL: "https://www.youtube.com/watch?v=some.id"
                                            )
    
    static let orderItem3 = Recipe(        id: "4",
                                           cuisine: "Chinsese", name: "Columbian",
                                           photoURLLarge: "food-placeholder",
                                           photoURLSmall: "food-placeholder",
                                           sourceURL: "https://some.url/index.html",
                                           youtubeURL: "https://www.youtube.com/watch?v=some.id"
                                            )
    
    static let orderItems = [orderItem1, orderItem2, orderItem3]
}
