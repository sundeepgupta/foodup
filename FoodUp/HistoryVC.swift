import UIKit

class HistoryVC: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private var dataController: DataController!
    
    func setDataController(dataController: DataController) {
        self.dataController = dataController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let meals = self.dataController.meals()
        self.textView.text = meals.description
    }
    
    @IBAction func done() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
