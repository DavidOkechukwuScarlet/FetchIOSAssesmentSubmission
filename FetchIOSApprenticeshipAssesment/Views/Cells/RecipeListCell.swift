//
//  RecipeListCell.swift
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//

import SwiftUI

struct RecipeListCell: View {
    
    let Recipe: Recipe
    var body: some View {
        HStack {
            RecipeRemoteImage(urlString: Recipe.photoURLLarge!)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .frame(width: 120, height: 73)

            VStack(alignment: .leading, spacing: 5) {
                Text(Recipe.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                
                Text(Recipe.cuisine)
                    .italic()
                    .font(.subheadline)
                    .foregroundStyle(.gray)

            }
            .padding(.leading)
            Spacer()
        }
    }
}

#Preview {
    RecipeListCell(Recipe: MockData.sampleRecipe)
}
