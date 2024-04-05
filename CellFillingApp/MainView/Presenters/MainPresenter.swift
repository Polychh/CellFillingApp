//
//  MainPresenter.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//

import Foundation


protocol MainViewProtocol: AnyObject{
    func reloadCollectionView()
    func scrollToDown(indexPath: IndexPath)
}

protocol MainPresenterProtocol{
    var data: [MainModel] { get }
    func generateRandomLive()
}

final class MainPresenter: MainPresenterProtocol{

    weak var view: MainViewProtocol?
    private var lastNewLiveIndex: Int?
    var data: [MainModel] = .init()
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    func generateRandomLive() {
        if checkCells(){
            let randomNumber = arc4random_uniform(2)
            switch randomNumber {
            case 0:
                let live = MainModel(image: .live, title: .live, subTitle: .live)
                data.append(live)
                view?.reloadCollectionView()
                let indexPath = IndexPath(item: data.count - 1, section: 0)
                view?.scrollToDown(indexPath: indexPath)
            case 1:
                let dead = MainModel(image: .dead, title: .dead, subTitle: .dead)
                data.append(dead)
                view?.reloadCollectionView()
                let indexPath = IndexPath(item: data.count - 1, section: 0)
                view?.scrollToDown(indexPath: indexPath)
            default:
                fatalError("Invalid random number")
            }
        }
    }
    
    private func checkCells() -> Bool {
        var liveCount = 0
        var deadCount = 0
        for  item in data {
            switch item.image {
            case .live:
                liveCount += 1
                deadCount = 0
            case .dead:
                liveCount = 0
                deadCount += 1
            case .newLive:
                liveCount = 0
                deadCount = 0
            }
        }
        
        if liveCount == 3 {
            let newItem = MainModel(image: .newLive, title: .newLive, subTitle: .newLive)
            print("append new Live")
            data.append(newItem)
            lastNewLiveIndex = data.count - 1
            view?.reloadCollectionView()
            let indexPath = IndexPath(item: data.count - 1, section: 0)
            view?.scrollToDown(indexPath: indexPath)
            return false
        }
        
        if deadCount == 3 {
            if let lastYepIndex = lastNewLiveIndex {
                data.remove(at: lastYepIndex)
                print("remove newLive \(lastYepIndex)")
                self.lastNewLiveIndex = nil
                view?.reloadCollectionView()
                return false
            }
        }
        return true
    }
}
