//
//  DataStore.swift
//  NaRogax
//
//  Created by User on 26/02/2019.
//  Copyright © 2019 Zappa. All rights reserved.
//

import Foundation
import UIKit

final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var dishes: [DishesList] = []
    
    let getDish = DataLoader()
    
    func getDishesList(completion: @escaping () -> Void) {
        
        let dataLoader = DataLoader()
        dataLoader.getDishes{items in self.dishes.append(contentsOf: items)}
        OperationQueue.main.addOperation {
            completion()
        }
    }

}
