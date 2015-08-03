import XCTest
@testable import FoodUp

class DataControllerTests: XCTestCase {
    
    var subject = DataController(defaults: NSUserDefaults())
    override func setUp() {
        super.setUp()
        subject = DataController(defaults: NSUserDefaults())
    }
    
    func testCreateMeal() {
        let type = MealType.Small
        let time = NSDate()
        let expected = Meal(type: type, time: time)
        
        subject.createMeal(type: type, time: time)
        
        XCTAssertEqual(subject.meals().last!, expected)
    }
    
    func testFetchingMeals() {
        
    }
    
    
    
}
