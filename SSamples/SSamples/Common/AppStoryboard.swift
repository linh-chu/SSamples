import UIKit

enum AppStoryboard: String {
    
    case main = "Main"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(_ viewControllerClass: T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        
        let storyboardID = "\(viewControllerClass as UIViewController.Type)"
        guard let vc =  instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return vc
    }
}

extension UIViewController {
    
    static func instantiate(from appStoryboard: AppStoryboard) -> Self {
        
        return appStoryboard.viewController(self)
    }
}
