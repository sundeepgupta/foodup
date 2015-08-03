import Foundation

class FakeDefaults: NSUserDefaults {
    var store = [String: AnyObject]()
    
    override func setObject(value: AnyObject?, forKey defaultName: String) {
        self.store[defaultName] = value
    }
    
    override func objectForKey(defaultName: String) -> AnyObject? {
        return self.store[defaultName]
    }
}
