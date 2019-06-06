//
//  KanjiModel.swift
//  MyKanji
//
//  Created by Sivan.Payyadakath on 2019/05/27.
//  Copyright © 2019 Sivan.Payyadakath. All rights reserved.
//

import Foundation

struct KanjiModel : Codable{
    
    let kanji: String
    let grade: Int
    let strokes: Int
    let meanings: [String]
    let kun: [String]
    let on: [String]
    let name: [String]
    let jlpt: Int
    let unicode: String
    
    enum CodingKeys: String, CodingKey {
        case kanji
        case grade
        case strokes = "stroke_count"
        case meanings
        case kun =  "kun_readings"
        case on = "on_readings"
        case name = "name_readings"
        case jlpt
        case unicode
    }
    
}

