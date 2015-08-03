import UIKit

class HistoryVC: UIViewController {
    @IBOutlet weak var smallLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var largeLabel: UILabel!
    private var history: History!
    
    func setHistory(history: History) {
        self.history = history
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
    }
    
    @IBAction func done() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func loadData() {
        self.smallLabel.text = "\(self.history.smallCount)"
        self.mediumLabel.text = "\(self.history.mediumCount)"
        self.largeLabel.text = "\(self.history.largeCount)"
    }
}
