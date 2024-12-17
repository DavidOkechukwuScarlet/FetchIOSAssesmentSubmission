//
//  ContentView.swift
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//

import SwiftUI

struct RecipeTabView: View {
    
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem { Label ("Home", systemImage: "house")
                    .environment(\.symbolVariants, .none) }
            
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
    }
}

#Preview {
    RecipeTabView()
}
