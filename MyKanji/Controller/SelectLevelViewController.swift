//
//  SelectLevelViewController.swift
//  MyKanji
//
//  Created by Sivan.Payyadakath on 2019/05/28.
//  Copyright © 2019 Sivan.Payyadakath. All rights reserved.
//

import UIKit

class SelectLevelViewController: UIViewController {

    var level : [String] = ["N5", "N4", "N3", "N2", "N1"]
    var rowSelected = 0
    var kanjiSet : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startLearning(_ sender: Any) {

            let urlPath = "https://kanjiapi.dev/v1/kanji/grade-\(self.rowSelected + 1)"
            self.getKanjiSetUrl(fetchUrl: urlPath, completionHandler: { (a) in
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "level", sender: sender)
                }
            })
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CardViewController
            controller.kanjiSet = self.kanjiSet
            controller.level = self.rowSelected + 1
  
    }
    
    func getKanjiSetUrl(fetchUrl: String, completionHandler: @escaping ([String]?) -> Void ){
        let urlPath = fetchUrl
        guard let url =  URL(string: urlPath) else {return}
        
        kanjiAPI.getKanjiLevelSet(url: url, completionHandler: { (c, e) in
            self.kanjiSet = c!
            completionHandler(c)
        })
        
    }
}

extension SelectLevelViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return level.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return level[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rowSelected = row
    }
}
