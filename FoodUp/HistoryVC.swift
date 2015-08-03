import UIKit

class HistoryVC: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func done() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
