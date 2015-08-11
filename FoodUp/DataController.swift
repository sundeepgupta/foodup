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
    
    func destroyLastMeal() -> Meal? {
        var mealData = self.archivedMeals()
        guard mealData.count > 0 else { return nil }
        
        let datum = mealData.removeLast()
        self.saveMealData(mealData)
        return self.mealFromDatum(datum)
    }
    
    func destroyMeal(meal: Meal) -> Bool {
        var mealData = self.archivedMeals()
        let meals = self.mealsFromData(mealData)

        guard let index = meals.indexOf(meal) else {
            return false
        }
        
        mealData.removeAtIndex(index)
        self.saveMealData(mealData)
        
        return true
    }
    
    func meals() -> [Meal] {
        return self.mealsFromData(self.archivedMeals())
    }
    
    
    // MARK: - Private
    private func mealsFromData(data: [NSData]) -> [Meal] {
        return data.map { datum in
            return self.mealFromDatum(datum)
        }
    }
    
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
