import XCTest
@testable import FoodUp

class MealTests: XCTestCase {

    var subject = Meal(type: .Small, time: NSDate())
    override func setUp() {
        super.setUp()
        subject = Meal(type: .Small, time: NSDate())
    }
    
    func testEncoding() {
        let key = "meal"
        let defaults = FakeDefaults()
        let before = NSKeyedArchiver.archivedDataWithRootObject(subject)
        defaults.setObject(before, forKey: key)
        defaults.synchronize()
        
        let after = defaults.objectForKey(key) as! NSData
        let result = NSKeyedUnarchiver.unarchiveObjectWithData(after) as! Meal
        XCTAssertEqual(result, subject)
    }
}
