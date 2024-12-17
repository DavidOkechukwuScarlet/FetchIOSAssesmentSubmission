//
//  NetworkManager.swift
//
//  Created by David Okechukwu on 12/16/2024.
//

import UIKit
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://d3jbb8n5wk0qxi.cloudfront.net/"
    
    static let recipeEndPoint = baseURL + "recipes.json"
    
    private init() {}
    
    func getRecipes(recipeEndPoint:String) async throws -> [Recipe] {
        guard let url = URL(string: recipeEndPoint) else {
            throw APError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(RecipeResponse.self, from: data).recipes
        } catch {
            print(error)
            throw APError.invalidData
        }
    }
    
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response,error in
            
            guard let data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
