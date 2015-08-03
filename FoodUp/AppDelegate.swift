import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupTrackVC()
        return true
    }
    
    func setupTrackVC() {
        let dataController = DataController(defaults: NSUserDefaults.standardUserDefaults())

        if let navigationController = self.window?.rootViewController as? UINavigationController {
            if let trackVC = navigationController.viewControllers.first as? TrackVC {
                trackVC.setDataController(dataController)
            }
        }
    }
}

