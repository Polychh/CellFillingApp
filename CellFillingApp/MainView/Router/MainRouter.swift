//
//  MainRouter.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//

import UIKit

protocol RouterProtocol{
    var navigationController: UINavigationController { get }
    func startVC()
}

protocol MainRouterProtocol: RouterProtocol{
    var builder: MainBuilderProtocol { get }
}

final class MainRouter: MainRouterProtocol{
    var builder: MainBuilderProtocol
    
    var navigationController: UINavigationController
    
    init(builder: MainBuilderProtocol, navigationController: UINavigationController) {
        self.builder = builder
        self.navigationController = navigationController
    }
    
    func startVC() {
        let mainVC = builder.buildMainVC()
        navigationController.setViewControllers([mainVC], animated: true)
    }
}
