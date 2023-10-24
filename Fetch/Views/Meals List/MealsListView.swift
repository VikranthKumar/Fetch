//
//  MealsListView.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/21/23.
//

import SwiftUI

struct MealsListView: View {
    
    @ObservedObject var viewModel: MealsListViewModel = MealsListViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let mealsData = viewModel.meals {
                    if let meals = mealsData.meals {
                        List(meals, id: \.self) { meal in
                            NavigationLink(value: meal.mealId) {
                                HStack {
                                    RemoteImage(url: meal.mealThumb)
                                        .frame(width: 40, height: 40)
                                    Text(meal.meal)
                                        .font(.extraSmall)
                                        .lineLimit(1)
                                }
                            }
                        }
                        .navigationDestination(for: String.self) { mealId in
                            MealDetailsView(mealId: mealId)
                        }
                        .refreshable {
                            viewModel.getMealsList()
                        }
                    } else {
                        EmptyDataView(type: .mealsList)
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
                            viewModel.getMealsList()
                        }
                    )
                }
            }
            .navigationTitle(String.mealsListViewTitle)
        }
        .onFirstAppear {
            viewModel.getMealsList()
        }
    }
    
}
