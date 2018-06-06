//
//  AppDelegate.swift
//  BuilditWeather
//
//  Created by Emrah Usar on 6/4/18.
//  Copyright © 2018 Emrah Usar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = AppCoordinator(window: window!)
        coordinator.dispatch()
        
        return true
    }

}

