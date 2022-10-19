//
//  FeatureListViewController.swift
//  BasicFeatures
//
//  Created by Arshdeep on 2022-10-17.
//

import UIKit

class FeatureListViewController: UIViewController {
    
    var featureListViewModel:FeatureListViewModel!
    static let reuseIdentifier = "featureIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViewModel()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeatureListViewController {
    func initViewModel() {
        featureListViewModel = FeatureListViewModel()
    }
}

extension FeatureListViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return featureListViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureListViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeatureListViewController.reuseIdentifier, for: indexPath) as! FeaturesListTableViewCell
        let data = featureListViewModel.dataForRow(at: indexPath)
        cell.titleLabel.text = data.name
        cell.subTitleLabel?.text = data.control
        return cell
    }
}

extension FeatureListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return featureListViewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return featureListViewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data = featureListViewModel.dataForRow(at: indexPath)

        switch data.control {
        case "Table View":
            performSegue(withIdentifier: "userIdentifier", sender: nil)
        case "Collection View":
            performSegue(withIdentifier: "userIdentifier", sender: nil)
        case "Image View":
            performSegue(withIdentifier: "userIdentifier", sender: nil)
        default:
            break
        }
    }
}

class FeaturesListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
}
