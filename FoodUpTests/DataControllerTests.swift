import XCTest
@testable import FoodUp

class DataControllerTests: XCTestCase {
    
    var subject = DataController(defaults: FakeDefaults())
    override func setUp() {
        super.setUp()
        subject = DataController(defaults: FakeDefaults())
    }
    
    func testCreateMeal() {
        let type = MealType.Small
        let time = NSDate()
        let expected = Meal(type: type, time: time)
        
        subject.createMeal(type: type, time: time)
        
        XCTAssertEqual(subject.meals().last!, expected)
    }
    
    func testFetchingMeals() {
        let type0 = MealType.Small
        let time0 = NSDate()
        let meal0 = Meal(type: type0, time: time0)
        
        let type1 = MealType.Medium
        let time1 = NSDate()
        let meal1 = Meal(type: type1, time: time1)
        
        let expected = [meal0, meal1]
        
        subject.createMeal(type: type0, time: time0)
        subject.createMeal(type: type1, time: time1)
        let result = subject.meals()
        
        XCTAssertEqual(result, expected)
    }
    
    
    
}
