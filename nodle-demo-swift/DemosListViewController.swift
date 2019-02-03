import UIKit

class DemosListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var nextViewController: UIViewController? = nil
        switch indexPath.row {
        case 0:
            nextViewController = SlidersViewController(nibName: nil, bundle: nil)
        default:
            nextViewController = nil
        }
        
        if  let viewControllerToPush = nextViewController,
            let navigationController = navigationController {
            navigationController.pushViewController(viewControllerToPush, animated: true)
        }
    }
}
