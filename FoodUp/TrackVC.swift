import UIKit
import WatchConnectivity


class TrackVC: UIViewController, WCSessionDelegate {
    private var dataController: DataController!
    private let session = WCSession.defaultSession()
    @IBOutlet private weak var smallCountLabel: UILabel!
    @IBOutlet private weak var mediumCountLabel: UILabel!
    @IBOutlet private weak var largeCountLabel: UILabel!
    @IBOutlet private weak var totalCountLabel: UILabel!
    
    
    func setDataController(dataController: DataController) {
        self.dataController = dataController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSession()
        UIApplication.sharedApplication().applicationSupportsShakeToEdit = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nc = segue.destinationViewController as! UINavigationController
        if let historyVC = nc.viewControllers.first as? HistoryVC {
            let history = HistoryBuilder(dataController: self.dataController).history()
            historyVC.setHistory(history)
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        guard motion == .MotionShake else { return }
        
        let delete = UIAlertAction(title: "Delete", style: .Destructive) { action -> Void in
            self.dataController.destroyLastMeal()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let alert = UIAlertController(title: "Delete last meal?", message: nil, preferredStyle: .Alert)
        alert.addAction(cancel)
        alert.addAction(delete)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - IBActions
    @IBAction private func ateSmallMeal() {
        self.createMeal(type: .Small)
        self.presentHistory()
    }
    
    @IBAction private func ateMediumMeal() {
        self.createMeal(type: .Medium)
        self.presentHistory()
    }
    
    @IBAction private func ateLargeMeal() {
        self.createMeal(type: .Large)
        self.presentHistory()
    }
    
    @IBAction private func seeHistory() {
        self.presentHistory()
    }
    
    

    // MARK: - WCSessionDelegate
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        let typeRawValue = applicationContext["type"] as! String
        if let type = MealType(rawValue: typeRawValue) {
            self.createMeal(type: type)
        }
    }
    
    
    // MARK: - Private
    private func setupSession() {
        self.session.delegate = self
        self.session.activateSession()
    }
    
    private func createMeal(type type: MealType) {
        self.dataController.createMeal(type: type, time: NSDate())
    }
    
    private func presentHistory() {
        self.performSegueWithIdentifier("trackToHistory", sender: nil)
    }
    
    
}

