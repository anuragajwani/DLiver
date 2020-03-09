//
//  AppDelegate.swift
//  DLiver
//
//  Created by Anurag Ajwani on 12/09/2019.
//  Copyright © 2019 Anurag Ajwani. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.registerDependencies()
        self.injectDependencies()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        let swinjectStoryboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: self.container)
        window.rootViewController = swinjectStoryboard.instantiateInitialViewController()
        return true
    }

    private func registerDependencies() {
        self.container.register(RestaurantLister.self, factory: { resolver in
            return ServerRestaurantLister()
        })
    }
    
    private func injectDependencies() {
        self.container.storyboardInitCompleted(RestaurantListTableViewController.self) { (resolver, viewController) in
            viewController.restaurantLister = resolver.resolve(RestaurantLister.self)
        }
    }
}

