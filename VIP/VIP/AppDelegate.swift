//
//  AppDelegate.swift
//  VIP
//
//  Created by raymond on 2021/10/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController()
        self.router = Router(navigationController: navigationController)
        self.router?.start()

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}

