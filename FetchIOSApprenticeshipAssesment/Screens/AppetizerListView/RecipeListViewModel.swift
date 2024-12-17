//
//  RecipeistViewModel.swift
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//

import SwiftUI

@MainActor final class RecipeListViewModel: ObservableObject {
    
    @Published var recipes: [Recipe] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var selectedRecipe: Recipe?
    @Published var searchedText:String = ""

    var filteredResults : [Recipe]{
        if(searchedText.isEmpty){
            return recipes
        }
    
        //Using streams, we can capture the viewmodels whose name property contains our searchText which changes upon the users keystrokes...
        return recipes.filter{ recipe in
        
            recipe.name.lowercased().starts(with: searchedText.lowercased()) || recipe.name.lowercased().starts(with: searchedText.lowercased()) || recipe.cuisine.lowercased().contains(searchedText.lowercased())
           
        }
    }
    
    func getRecipes() {
        isLoading = true
        
        Task {
            do {
                recipes = try await NetworkManager.shared.getRecipes(recipeEndPoint: NetworkManager.recipeEndPoint)
                isLoading = false
            } catch {
                print(error)
                if let apError = error as? APError {
                    switch apError {
                    case .invalidURL:
                        alertItem = AlertContext.invalidURl
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                } else {
                    alertItem = AlertContext.invalidResponse
                }
                
                isLoading = false
            }
        }
    }
}
