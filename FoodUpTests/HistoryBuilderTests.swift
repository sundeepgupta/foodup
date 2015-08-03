import XCTest
@testable import FoodUp

class HistoryBuilderTests: XCTestCase {
    
    var subject: HistoryBuilder!
    
    func testHistoryOutput() {
        let dataController = DataController(defaults: FakeDefaults())
        dataController.createMeal(type: .Small, time: NSDate())
        dataController.createMeal(type: .Small, time: NSDate())
        dataController.createMeal(type: .Medium, time: NSDate())
        
        subject = HistoryBuilder(dataController: dataController)
        let history = subject.history()
        
        XCTAssertEqual(history.smallCount, 2)
        XCTAssertEqual(history.mediumCount, 1)
        XCTAssertEqual(history.largeCount, 0)
    }
}
