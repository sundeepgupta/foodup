import Foundation

class Meal: NSObject, NSCoding {
    let id: Int
    let type: MealType
    let time: NSDate
    
    init(type: MealType, time: NSDate, id: Int = -1) {
        self.id = id
        self.type = type
        self.time = time
        super.init()
    }
    
    required convenience init?(coder decoder: NSCoder) {
        let id = decoder.decodeIntegerForKey("id")
        let time = decoder.decodeObjectForKey("time") as! NSDate
        
        let typeValue = decoder.decodeObjectForKey("type") as! String
        if let typeEnum = MealType(rawValue: typeValue) {
            self.init(type: typeEnum, time: time, id: id)
        } else {
            fatalError("Meal type string from archive not recognized.")
        }
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.id, forKey: "id")
        coder.encodeObject(self.type.rawValue, forKey: "type")
        coder.encodeObject(self.time, forKey: "time")
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? Meal else {
            return false
        }
        
        return self.type == rhs.type && self.time == rhs.time
    }

    func stringRepresentation() -> String {
        return "Type: \(self.type.rawValue) Time: \(self.time)"
    }
}
