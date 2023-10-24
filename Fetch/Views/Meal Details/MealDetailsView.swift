//
//  MealDetailsView.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/23/23.
//

import SwiftUI

struct MealDetailsView: View {
    
    @ObservedObject var viewModel: MealDetailsViewModel = MealDetailsViewModel()
    @Environment(\.openURL) var openUrl
    
    let mealId: String
    
    var body: some View {
        VStack {
            if let meal = viewModel.meal {
                ScrollView {
                        RemoteImage(url: meal.mealThumb)
                            .fullWidth()
                            .frame(height: UIScreen.main.bounds.width)
                        VStack(alignment: .leading, spacing: 20) {
                            Text(meal.meal)
                                .font(.large)
                            if let tags = meal.tags {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(String.tags)
                                        .font(.small)
                                    WrappingHStack(alignment: .leading) {
                                        ForEach(tags){ tag in
                                            Text(tag)
                                                .font(.extraSmallRegular)
                                                .foregroundColor(.white)
                                                .padding(4)
                                                .background(.black)
                                                .cornerRadius(4)
                                        }
                                    }
                                }
                            }
                            if let ingredients = meal.ingredients {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(String.ingredients)
                                        .font(.small)
                                    Grid {
                                        Divider()
                                        GridRow {
                                            Text(String.ingredient)
                                            Text(String.measure)
                                        }
                                        .font(.small)
                                        Divider()
                                        ForEach(ingredients) { ingredient in
                                            GridRow {
                                                Text(ingredient.ingredient)
                                                Text(ingredient.measure)
                                            }
                                            .font(.extraSmallRegular)
                                            Divider()
                                        }
                                    }
                                    .border(.gray)
                                }
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                Text(String.method)
                                    .font(.small)
                                Text(meal.instructions.unWrapped)
                                    .font(.extraSmallRegular)
                            }
                            HStack {
                                if let youtubeUrl = viewModel.meal?.youtube?.url {
                                    Button(action: {
                                        openUrl(youtubeUrl)
                                    }) {
                                        Text(String.youtube)
                                    }
                                    .primaryButton()
                                }
                                if let sourceUrl = viewModel.meal?.source?.url {
                                    Button(action: {
                                        openUrl(sourceUrl)
                                    }) {
                                        Text(String.source)
                                    }
                                    .primaryButton()
                                }
                            }
                            Spacer()
                        }
                        .padding()
                }
            } else {
                LoaderView(
                    didFail: .init(
                        get: {
                            viewModel.isError
                        }, set: { value in
                            viewModel.isError = value
                        }
                    ), action: {
                        viewModel.getMealDetails(mealId: mealId)
                    }
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
        .onFirstAppear {
            viewModel.getMealDetails(mealId: mealId)
        }
    }
    
}
