//
//  SceneDelegate.swift
//  BookmarkCollection
//
//  Created by Erik on 04.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let linkManager = LinkManager.shared
        let isLinksEmpty = linkManager.getLinks().isEmpty
        let rootViewController: UIViewController
        if isLinksEmpty {
            rootViewController = WelcomeView()
        } else {
            rootViewController = MainView()
        }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        self.window = window
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

