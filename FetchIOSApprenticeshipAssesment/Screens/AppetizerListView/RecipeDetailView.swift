//
//  FetchIOSApprenticeshipAssesment
//
//  Created by David Okechukwu on 12/16/24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    
    let recipe: Recipe
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        ZStack{
            Color.black.brightness(0.1)
                .ignoresSafeArea(.all)
                .opacity(0.5)
                .onTapGesture {
                    isShowingDetail = false
                }
            VStack {
                RecipeRemoteImage(urlString: recipe.photoURLLarge!)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 225)
                    .padding()
                
                VStack {
                    Text(recipe.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(width: 300,height: 60)
                        .multilineTextAlignment(.center)
                    Text("\(recipe.cuisine) Cuisine")
                        .italic()
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundStyle(.gray)
                        .padding(.bottom)
                    
                   
                        VStack(){

                            Label("Recipe Information...", systemImage: "info.circle.fill")
                                .padding()
                            Label {
                                Link("Website Information", destination: URL(string:"https://www.google.com")!)
                                    .foregroundStyle(.white)
                                
                               
                            } icon: {
                                
                                Image("websiteIcon")
                                    .resizable()
                                    .frame(width: 25,height: 25)
                                
                            }
                            .frame(width: 250, height: 40)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.leading)
                            
                            Label {
                                Link("Youtube Information", destination: URL(string:recipe.youtubeURL!)!)
                                    .foregroundStyle(.white)


                            } icon: {
                                Image("youtubeIcon")
                                    .resizable()
                                    .frame(width: 25,height: 25)
                                


                            }
                            .frame(width: 250, height: 40)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding(.leading)
                            
                        }
                        Spacer()
                    
                }
                .padding(.top)
                Spacer()
                
                Button {
                    isShowingDetail = false
                } label: {
                    
                }
                .padding(.bottom, 30)
                
            }
            .frame(width: 300, height: 525)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 40)
            .overlay(Button {
                isShowingDetail = false
            } label: {
                XDismissButton()
                    .shadow(color:.red, radius: 3)
            }, alignment: .topTrailing)
        }
    }
}

#Preview {
    RecipeDetailView(recipe: MockData.sampleRecipe, isShowingDetail: .constant(true))
}
