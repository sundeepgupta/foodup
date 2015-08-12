import UIKit
import WatchConnectivity


class TrackVC: UIViewController, WCSessionDelegate, TodayControllerDelegate {
    private var dataController: DataController!
    private let session = WCSession.defaultSession()
    @IBOutlet private weak var smallCountLabel: UILabel!
    @IBOutlet private weak var mediumCountLabel: UILabel!
    @IBOutlet private weak var largeCountLabel: UILabel!
    @IBOutlet private weak var totalCountLabel: UILabel!
    var todayController: TodayController!
    
    
    func updateWithModel(model: TodayModel) {
        self.smallCountLabel.text = "\(model.smallCount)"
        self.mediumCountLabel.text = "\(model.mediumCount)"
        self.largeCountLabel.text = "\(model.largeCount)"
    }
    
    
    func setDataController(dataController: DataController) {
        self.dataController = dataController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.session.delegate = self
        self.session.activateSession()
        
        self.todayController = TodayController(delegate: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nc = segue.destinationViewController as! UINavigationController
        if let historyVC = nc.viewControllers.first as? HistoryVC {
            let history = HistoryBuilder(dataController: self.dataController).history()
            historyVC.setHistory(history)
        }
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
    private func createMeal(type type: MealType) {
        self.dataController.createMeal(type: type, time: NSDate())
    }
    
    private func presentHistory() {
        self.performSegueWithIdentifier("trackToHistory", sender: nil)
    }
    
    
}

