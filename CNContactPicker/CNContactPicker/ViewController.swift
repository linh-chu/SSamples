import ContactsUI
import UIKit

class ViewController: UIViewController, CNContactPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let cnPicker = CNContactVC()
        cnPicker.delegate = self
        
        self.present(cnPicker, animated: true, completion: nil)

        
    }
    
    //MARK:- CNContactPickerDelegate Method
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
    }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    func checkSubview(of view: UIView) {
        for subview in view.subviews {
            
            if subview is UISearchBar {
                subview.isHidden = true
            }
            
            if subview is UITableView {
                subview.isHidden = true
            }
            
            if type(of: subview) == UISearchBar.self {
                subview.isHidden = true
            }
            
            print(type(of: subview))
            checkSubview(of: subview)
        }
    }
    
    
    
}

class CNContactVC: CNContactPickerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        //        if type(of: navigationController.topViewController) == UISearchController.self {
//        if let current = navigationController.topViewController as? UISearchController {
//            current.searchBar.isHidden = true
//        }
//        //        }
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        for subview in self.view.subviews {
//            
//            if let searchBar = subview as? UISearchBar {
//                searchBar.isHidden = true
//                print("abc")
//            }
//            
//            if subview.isKind(of: UISearchBar.self) {
//               subview.isHidden = true
//            }
//            
//            if subview.isKind(of: UITableView.self) {
//                subview.isHidden = true
//            }
//            
//            if subview is UISearchBar {
//                subview.isHidden = true
//            }
//            
//            if subview is UITableView {
//                subview.isHidden = true
//            }
//            
//            if subview.isMember(of: UISearchBar.self) {
//                subview.isHidden = true
//            }
//            
//            
//            print(subview.self)
//        }
        

//        for childVC in self.childViewControllers {
//            
//        }
        
//        checkSubview(of: self.view)
//        po let s = view.perform("recursiveDescription")
//        checkVC(of: self)
        
        
    }
    
    func checkVC(of vc: UIViewController) {
        for child in vc.childViewControllers {
            checkSubview(of: child.view)
            checkVC(of: child)
        }
    }
    
    func checkSubview(of view: UIView) {
        for subview in view.subviews {
            
            if subview is UISearchBar {
                subview.isHidden = true
            }

            if subview is UITableView {
                subview.isHidden = true
            }

            if type(of: subview) == UISearchBar.self {
                subview.isHidden = true
            }
            
            print(type(of: subview))
            checkSubview(of: subview)
        }
    }
}

extension UINavigationController {
    
}


 
