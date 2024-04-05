//
//  MainModel.swift
//  CellFillingApp
//
//  Created by Polina on 04.04.2024.
//

import Foundation


struct MainModel{
    let image: ImageType
    let title: TitleType
    let subTitle: SubTitleType
}

enum ImageType{
    case live
    case dead
    case newLive
}

enum TitleType: String{
    case live = "Жива"
    case dead = "Мертвая"
    case newLive = "Жизнь"
}

enum SubTitleType: String{
    case live = "или прикидывается"
    case dead = "и шевелится!"
    case newLive = "Ку-ку"
}
