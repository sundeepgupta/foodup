import UIKit
import WatchConnectivity


class TrackVC: UIViewController, WCSessionDelegate {
    private var dataController: DataController!
    private let session = WCSession.defaultSession()
    
    func setDataController(dataController: DataController) {
        self.dataController = dataController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.session.delegate = self
        self.session.activateSession()
    }
    
    @IBAction func ateSmallMeal() {
        self.createMeal(type: .Small)
        self.presentHistory()
    }
    
    @IBAction func ateMediumMeal() {
        self.createMeal(type: .Medium)
        self.presentHistory()
    }
    
    @IBAction func ateLargeMeal() {
        self.createMeal(type: .Large)
        self.presentHistory()
    }

    @IBAction func seeHistory() {
        self.presentHistory()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nc = segue.destinationViewController as! UINavigationController
        if let historyVC = nc.viewControllers.first as? HistoryVC {
            let history = HistoryBuilder(dataController: self.dataController).history()
            historyVC.setHistory(history)
        }
    }
    

    // MARK: - WCSessionDelegate
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        let typeRawValue = applicationContext["type"] as! String
        if let type = MealType(rawValue: typeRawValue) {
            self.createMeal(type: type)
        }
    }
    
    
    // MARK: - Private
    private func createMeal(type type: MealType) {
        self.dataController.createMeal(type: type, time: NSDate())
    }
    
    private func presentHistory() {
        self.performSegueWithIdentifier("trackToHistory", sender: nil)
    }
    
    
}

