import Foundation

protocol TodayControllerDelegate {
    func updateWithModel(model: TodayModel)
}


class TodayController {
    let delegate: TodayControllerDelegate
    
    init(delegate: TodayControllerDelegate) {
        self.delegate = delegate
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fetchResults", name: "dataDidUpdate", object: nil)
    }
    
    dynamic func fetchResults() {
        let model = TodayModel(smallCount: 1, mediumCount: 2, largeCount: 3)
        self.delegate.updateWithModel(model)
    }
}