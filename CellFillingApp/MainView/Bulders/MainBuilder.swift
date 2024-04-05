//
//  MainBuilder.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//

import UIKit

protocol MainBuilderProtocol{
    func buildMainVC() -> UIViewController
}


final class MainBuilder: MainBuilderProtocol{
    
    func buildMainVC() -> UIViewController {
        let vc = MainViewController()
        let presenter = MainPresenter(view: vc)
        vc.presenter = presenter
        return vc
    }
    
    
}
