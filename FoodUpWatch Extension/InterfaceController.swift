import WatchKit
import WatchConnectivity
import Foundation

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBAction func ateSmallMeal() {
        let session = WCSession.defaultSession()
        session.delegate = self
        session.activateSession()
        let context = ["type": "Small"]
        
        do {
            try session.updateApplicationContext(context)
        } catch {
            
        }
    }

    @IBAction func ateMediumMeal() {
    }

    @IBAction func ateLargeMeal() {
    }
}
