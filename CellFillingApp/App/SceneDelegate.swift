//
//  SceneDelegate.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController()
        let builder = MainBuilder()
        let router = MainRouter(builder: builder, navigationController: nav)
        window.rootViewController = nav
        router.startVC()
        self.window = window
        window.makeKeyAndVisible()
    }
}

