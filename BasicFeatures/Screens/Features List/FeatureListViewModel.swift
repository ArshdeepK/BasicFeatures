//
//  FeatureListViewModel.swift
//  BasicFeatures
//
//  Created by Arshdeep on 2022-10-16.
//

import Foundation
import UIKit

class FeatureListViewModel {
    
    let features:[Feature]
    
    init() {
        features = [Feature(name: "Users", control: "Table View"), Feature(name: "Gallery", control: "Collection View"), Feature(name: "Detail", control: "Text View"), Feature(name: "Remote Image", control: "Image View")]
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        return features.count
    }
    
    func dataForRow(at indexPath:IndexPath) -> Feature {
        return features[indexPath.row]
    }
    
    func heightForRow(at indexPath:IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
