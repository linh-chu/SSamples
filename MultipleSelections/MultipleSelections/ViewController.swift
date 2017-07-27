import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let fruits = ["Apples", "Oranges", "Grapes", "Watermelon", "Peaches"]
    
    var newFruitList:[String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(animateText), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    func animateText() {
        UIView.animate(withDuration: 2.0) { 
            self.label.transform = CGAffineTransform(translationX: 50, y: 100)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillEnterForeground, object: nil);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = fruits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newFruitList.append(fruits[indexPath.row])
        print("New List: \(newFruitList)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = newFruitList.index(of: fruits[indexPath.row]) {
            newFruitList.remove(at: index)
        }
        print("New List: \(newFruitList)")
    }
}

