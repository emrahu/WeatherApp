//
//  AppCoordinator.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import Foundation
import UIKit
class AppCoordinator {
    
    var window: UIWindow?
    init(window:UIWindow) {
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    func dispatch(){
        let weatherViewController = WeatherViewController()
        let navigationController = UINavigationController(rootViewController: weatherViewController)
        self.window?.rootViewController = navigationController
    }
}
