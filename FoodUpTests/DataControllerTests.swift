import XCTest
@testable import FoodUp

class DataControllerTests: XCTestCase {
    
    var subject: DataController!
    override func setUp() {
        super.setUp()
        subject = DataController(defaults: FakeDefaults())
    }
    
    func testCreateMeal() {
        let type = MealType.Small
        let time = NSDate()
        let expected = Meal(type: type, time: time, id: 1)
        let existingMeals = subject.meals()
        
        let result = subject.createMeal(type: type, time: time)
        let meals = subject.meals()

        XCTAssertEqual(meals.last!, expected)
        XCTAssertEqual(result, expected)
        XCTAssertEqual(meals.count, existingMeals.count + 1)
    }
    
    func testFirstMealId() {
        let type = MealType.Small
        let time = NSDate()
        let existingMeals = subject.meals()
        XCTAssertEqual(existingMeals.count, 0)
        
        subject.createMeal(type: type, time: time)
        let meals = subject.meals()
        
        XCTAssertEqual(meals.last!.id, 1)
    }
    
    func testIncrementingMealIds() {
        let type0 = MealType.Small
        let time0 = NSDate()
        let meal0 = Meal(type: type0, time: time0, id: 1)
        
        let type1 = MealType.Medium
        let time1 = NSDate()
        let meal1 = Meal(type: type1, time: time1, id: 2)
        
        let expected = [meal0, meal1]
        
        subject.createMeal(type: type0, time: time0)
        subject.createMeal(type: type1, time: time1)
        let result = subject.meals()
        
        XCTAssertEqual(result, expected)
    }
}
