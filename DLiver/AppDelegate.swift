//
//  AppDelegate.swift
//  DLiver
//
//  Created by Anurag Ajwani on 12/09/2019.
//  Copyright © 2019 Anurag Ajwani. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerDependencies()
        let navigationController = self.window?.rootViewController as? UINavigationController
        let restaurantListViewController = navigationController?.viewControllers[0] as? RestaurantListTableViewController
        restaurantListViewController?.restaurantLister = container.resolve(RestaurantLister.self)
        return true
    }

    private func registerDependencies() {
        self.container.register(RestaurantLister.self, factory: { resolver in
            return ServerRestaurantLister()
        })
    }
}

