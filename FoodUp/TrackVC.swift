import UIKit

class TrackVC: UIViewController {

    @IBAction func ateSmallMeal() {
        
    }
    
    @IBAction func ateMediumMeal() {
        
    }
    
    @IBAction func ateLargeMeal() {
        
    }

    @IBAction func seeHistory() {
        self.performSegueWithIdentifier("trackToHistory", sender: nil)
    }
}

