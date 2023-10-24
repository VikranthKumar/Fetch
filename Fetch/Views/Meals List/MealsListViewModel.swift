//
//  MealsListViewModel.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/21/23.
//

import Foundation
import Combine

class MealsListViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    @Published var meals: Meals?
    
    var cancellable: AnyCancellable?
    
    func getMealsList() {
        cancellable = NetworkSession.shared.task(with: .mealsList)
            .receive(on: DispatchQueue.main)
            .tryMap { try $0.unwrap(NetworkResponse.mealsList) }
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
                    self.meals = meals
                    self.isLoading = false
                }
            )
    }
    
}
