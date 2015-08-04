import WatchKit
import WatchConnectivity
import Foundation

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    let session = WCSession.defaultSession()
    
    override init() {
        super.init()
        
        self.session.delegate = self
        self.session.activateSession()
    }

    @IBAction func ateSmallMeal() {
        self.createMeal("Small")
    }

    @IBAction func ateMediumMeal() {
        self.createMeal("Medium")
    }

    @IBAction func ateLargeMeal() {
        self.createMeal("Large")
    }
    

    private func createMeal(type: String) {
        let context = ["type": type]
        do {
            try session.updateApplicationContext(context)
        } catch let error as NSError {
            print("Error sending meal to phone: \(error)")
        }
    }
}
