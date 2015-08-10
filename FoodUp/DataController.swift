import Foundation

struct DataController {
    private let defaults: NSUserDefaults
    private let key = "meals"
    
    init(defaults: NSUserDefaults) {
        self.defaults = defaults
    }
    
    func createMeal(type type: MealType, time: NSDate) -> Meal {
        var mealData = self.archivedMeals()
        let id = self.nextIdFromMealData(mealData)
        let meal = Meal(type: type, time: time, id: id)
        let datum = NSKeyedArchiver.archivedDataWithRootObject(meal)

        mealData.append(datum)
        
        self.saveMealData(mealData)

        return meal
    }
    
    func meals() -> [Meal] {
        let data = self.archivedMeals()
        guard data.count > 0 else { return [] }
        
        return data.map { datum in
            return self.mealFromDatum(datum)
        }
    }
    
    
    // MARK: - Private
    private func saveMealData(data: [NSData]) {
        self.defaults.setObject(data, forKey: self.key)
        self.defaults.synchronize()
    }
    
    private func archivedMeals() -> [NSData] {
        guard let object = self.defaults.arrayForKey(self.key) else { return [] }
        
        return object.map { datum in
            return datum as! NSData
        }
    }
    
    private func mealFromDatum(datum: NSData) -> Meal {
        guard let meal = NSKeyedUnarchiver.unarchiveObjectWithData(datum) else {
            fatalError("Could not unarchive meal from storage.")
        }
        
        return meal as! Meal
    }
    
    private func nextIdFromMealData(data: [NSData]) -> Int {
        var id = 1
        if data.count > 0 {
            let lastMeal = self.mealFromDatum(data.last!)
            id = lastMeal.id + 1
        }
        
        return id
    }
    
}
