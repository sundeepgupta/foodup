import UIKit

class TrackVC: UIViewController {
    private var dataController: DataController!
    
    func setDataController(dataController: DataController) {
        self.dataController = dataController;
    }
    
    @IBAction func ateSmallMeal() {
        self.processMeal(type: .Small)
    }
    
    @IBAction func ateMediumMeal() {
        self.processMeal(type: .Medium)
    }
    
    @IBAction func ateLargeMeal() {
        self.processMeal(type: .Large)
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
    
    private func processMeal(type type: MealType) {
        self.dataController.createMeal(type: type, time: NSDate())
        self.presentHistory()
        
    }
    
    private func presentHistory() {
        self.performSegueWithIdentifier("trackToHistory", sender: nil)
    }
    
    
}

