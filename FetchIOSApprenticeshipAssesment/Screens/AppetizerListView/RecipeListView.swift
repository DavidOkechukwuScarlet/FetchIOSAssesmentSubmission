//
//  RecipeListView.swift
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @StateObject var viewModel = RecipeListViewModel()
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.filteredResults) { recipe in
                    RecipeListCell(Recipe: recipe)
                        .listRowSeparator(.visible, edges: .all)
                        .onTapGesture {
                            withAnimation{
                                viewModel.selectedRecipe = recipe
                                viewModel.isShowingDetail = true
                            }
                        }
                    
                }
                .refreshable {
                    viewModel.recipes.removeAll()
                    viewModel.getRecipes()
                }
                .searchable(text: $viewModel.searchedText,prompt: "Search for recipe or cuisine...")
                .listStyle(.plain)
                .navigationTitle("🍽️ Recipes")
                .disabled(viewModel.isShowingDetail)
            }
            .task {
                viewModel.getRecipes()
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                    RecipeDetailView(recipe: viewModel.selectedRecipe!,
                                     isShowingDetail: $viewModel.isShowingDetail)
                
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.extraLarge)
            }
            
            //Handle Empty State where no recipes are found from the data
            if(viewModel.recipes.isEmpty && !viewModel.isLoading){
                ContentUnavailableView("There are no recipes available ", image: "confusedFace")
            }
            
            

        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dissmissButton)
        }
    }
}

#Preview {
    RecipeListView()
}
