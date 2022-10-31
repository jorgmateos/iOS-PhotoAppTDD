//
//  SpyNavigationController.swift
//  PhotoAppTests
//
//  Created by Jorge Garcia Mateos on 25/10/22.
//

import UIKit

class SpyNavigationController: UINavigationController {
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        pushedViewController = viewController
    }
}
