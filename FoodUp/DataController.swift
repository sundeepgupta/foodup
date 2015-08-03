import Foundation

struct DataController {
    private let defaults: NSUserDefaults
    private let key = "meals"
    
    init(defaults: NSUserDefaults) {
        self.defaults = defaults
    }
    
    func createMeal(type type: MealType, time: NSDate) {
        let meal = Meal(type: type, time: time)
        let datum = NSKeyedArchiver.archivedDataWithRootObject(meal)

        var mealData = self.archivedMeals()
        mealData.append(datum)
        
        self.defaults.setObject(mealData, forKey: self.key)
        self.defaults.synchronize()
    }
    
    func meals() -> [Meal] {
        let data = self.archivedMeals()
        guard data.count > 0 else { return [] }
        

        let mapper: (NSData) -> (Meal) = { datum in
            if let unarchivedMeal = NSKeyedUnarchiver.unarchiveObjectWithData(datum) {
                return unarchivedMeal as! Meal
            } else {
                fatalError("Could not unarchive meal data.")
            }
        }
        
        return data.map(mapper)
    }
    
    private func archivedMeals() -> [NSData] {
        guard let object = self.defaults.arrayForKey(self.key) else { return [] }
        
        return object.map { datum in
            return datum as! NSData
        }
    }
}
