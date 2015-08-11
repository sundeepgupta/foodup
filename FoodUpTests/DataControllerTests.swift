import XCTest
@testable import FoodUp

class DataControllerTests: XCTestCase {
    var subject: DataController!
    var type: MealType!
    var time: NSDate!
    
    override func setUp() {
        super.setUp()
        subject = DataController(defaults: FakeDefaults())
        type = MealType.Small
        time = NSDate()
    }
    
    func testCreateMeal() {
        let expected = Meal(type: type, time: time, id: 1)
        let existingMeals = subject.meals()
        
        let result = subject.createMeal(type: type, time: time)
        let meals = subject.meals()

        XCTAssertEqual(meals.last!, expected)
        XCTAssertEqual(result, expected)
        XCTAssertEqual(meals.count, existingMeals.count + 1)
    }
    
    func testFirstMealId() {
        let existingMeals = subject.meals()
        XCTAssertEqual(existingMeals.count, 0)
        
        subject.createMeal(type: type, time: time)
        let meals = subject.meals()
        
        XCTAssertEqual(meals.last!.id, 1)
    }
    
    func testIncrementingMealIds() {
        let meal0 = Meal(type: type, time: time, id: 1)
        
        let type1 = MealType.Medium
        let time1 = NSDate()
        let meal1 = Meal(type: type1, time: time1, id: 2)
        
        let expected = [meal0, meal1]
        
        subject.createMeal(type: type, time: time)
        subject.createMeal(type: type1, time: time1)
        let result = subject.meals()
        
        XCTAssertEqual(result, expected)
    }
    
    func testDeletingMealsWhenItExists() {
        let meal = subject.createMeal(type: type, time: time)

        let result = subject.destroyMeal(meal)
        
        let meals = subject.meals()
        
        XCTAssertFalse(meals.contains(meal))
        XCTAssertTrue(result)
    }
    
    func testDeletingMealsWhenItDoesNotExist() {
        let meal = Meal(type: type, time: time, id: 99)
        let result = subject.destroyMeal(meal)
        XCTAssertFalse(result)
    }
    
    func testDeletingLastMealWhenExists() {
        let meal = subject.createMeal(type: type, time: time)
        
        let result = subject.destroyLastMeal()
        
        let meals = subject.meals()
        
        XCTAssertFalse(meals.contains(meal))
        XCTAssertEqual(meal, result!)
    }
    
    func testDeletingLastMealWhenThereAreNoMeals() {
        let result = subject.destroyLastMeal()

        XCTAssertNil(result)
    }
}
