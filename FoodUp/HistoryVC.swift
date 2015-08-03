import UIKit

class HistoryVC: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private var dataController: DataController!
    
    func setDataController(dataController: DataController) {
        self.dataController = dataController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
    }
    
    @IBAction func done() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func loadData() {
        let meals = self.dataController.meals()
        let reducer: (String, Meal) -> String = { memo, meal in
            return memo + meal.stringRepresentation() + "\n"
        }
        let description = meals.reduce("", combine: reducer)

        self.textView.text = description
    }
}
