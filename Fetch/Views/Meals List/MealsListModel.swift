//
//  ListModel.swift
//  Fetch
//
//  Created by Vikranth Kumar on 10/22/23.
//

import Foundation

struct Meals: Codable {
    let meals: [Meal]?
    
    struct Meal: Codable, Hashable {
        let mealId: String
        let meal: String
        let mealThumb: String
        let instructions: String?
        let tags: [String]?
        let youtube: String?
        let source: String?
        let ingredients: [Ingredient]?
        
        struct Ingredient: Identifiable {
            let ingredient: String
            let measure: String
            
            var id: Int {
                ingredient.hash
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case mealId = "idMeal", meal = "strMeal", mealThumb = "strMealThumb", instructions = "strInstructions", tags = "strTags", youtube = "strYoutube", source = "strSource", strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20, strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20, `default`
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            mealId = try container.decode(String.self, forKey: .mealId)
            meal = try container.decode(String.self, forKey: .meal)
            mealThumb = try container.decode(String.self, forKey: .mealThumb)
            instructions = try? container.decode(String.self, forKey: .instructions)
            tags = try? container.decode(String.self, forKey: .tags).components(separatedBy: String.comma)
            youtube = try? container.decode(String.self, forKey: .youtube)
            source = try? container.decode(String.self, forKey: .source)
            ingredients = (1...20).compactMap { index in
                guard let ingredient = try? container.decode(String.self, forKey: CodingKeys(rawValue: "strIngredient\(index)") ?? .default), let measure = try? container.decode(String.self, forKey: CodingKeys(rawValue: "strMeasure\(index)") ?? .default) else {
                    return nil
                }
                return Ingredient(ingredient: ingredient, measure: measure)
            }.filter { !($0.ingredient.empty || $0.measure.empty) }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(mealId, forKey: .mealId)
            try container.encode(meal, forKey: .meal)
            try container.encode(mealThumb, forKey: .mealThumb)
            try? container.encode(instructions, forKey: .instructions)
            try? container.encode(tags, forKey: .tags)
            try? container.encode(youtube, forKey: .youtube)
            try? container.encode(source, forKey: .source)
            if let ingredients = ingredients {
                for (index, ingredient) in ingredients.enumerated() {
                    try? container.encode(ingredient.ingredient, forKey: CodingKeys(rawValue: "strIngredient\(index + 1)") ?? .default)
                    try? container.encode(ingredient.measure, forKey: CodingKeys(rawValue: "strMeasure\(index + 1)") ?? .default)
                }
            }
        }
        
        static func == (lhs: Meals.Meal, rhs: Meals.Meal) -> Bool {
            lhs.mealId == rhs.mealId
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(mealId)
        }
    }
}
