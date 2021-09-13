//
//  AppDelegate.swift
//  MVVM_C
//
//  Created by raymond on 2021/09/12.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?


    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let navigationController = UINavigationController()
        self.appCoordinator = AppCoordinator(navigationController: navigationController)
        self.appCoordinator?.start()

        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

        return true
    }
}

