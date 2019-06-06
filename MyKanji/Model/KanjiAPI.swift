//
//  KanjiAPI.swift
//  MyKanji
//
//  Created by Sivan.Payyadakath on 2019/05/27.
//  Copyright © 2019 Sivan.Payyadakath. All rights reserved.
//

import Foundation
import UIKit

class kanjiAPI{
    
    class func getKanjiResponse(url: URL, completionHandler: @escaping (KanjiModel?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    completionHandler(nil, error)
                    return }
            do{
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let kanjiResponse = try decoder.decode(KanjiModel.self, from: data)
                completionHandler(kanjiResponse, nil)
//                self.displayInView(data: kanjiResponse)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    class func getKanjiLevelSet(url: URL, completionHandler: @escaping ([String]?, Error?) -> Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                error == nil else {
                    completionHandler(nil, error)
                    return }
            do{
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let kanjiSet = try decoder.decode([String].self, from: data)
                completionHandler(kanjiSet, nil)
                //self.displayInView(data: kanjiResponse)
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    
}
