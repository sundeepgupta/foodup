import Foundation

struct HistoryBuilder {
    private let dataController: DataController
    private let meals: [Meal]
    
    init(dataController: DataController) {
        self.dataController = dataController
        self.meals = dataController.meals()
    }
    
    func history() -> History {
        let smallCount = self.countFor(type: .Small)
        let mediumCount = self.countFor(type: .Medium)
        let largeCount = self.countFor(type: .Large)
        
        return History(smallCount: smallCount, mediumCount: mediumCount, largeCount: largeCount)
    }
    
    private func countFor(type type: MealType) -> Int {
        return self.meals.reduce(0) { memo, meal in
            return type == meal.type ? memo + 1 : memo
        }
    }
}