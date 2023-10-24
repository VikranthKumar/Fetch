//
//  MealDetailsViewModel.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/23/23.
//

import Foundation
import Combine

class MealDetailsViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var meal: Meals.Meal?
    
    var cancellable: AnyCancellable?
    
    func getMealDetails(mealId: String) {
        cancellable = NetworkSession.shared.task(with: .mealDetails(mealId: mealId))
            .receive(on: DispatchQueue.main)
            .tryMap {
                try $0.unwrap(NetworkResponse.mealDetails)
            }
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            self.isError = false
                            self.errorMessage = ""
                        case .failure(let error):
                            self.isError = true
                            self.errorMessage = error.localizedDescription
                    }
                    self.isLoading = false
                }, receiveValue: { meals in
                    self.meal = meals.meals?.first
                    self.isLoading = false
                }
            )
    }
    
}
