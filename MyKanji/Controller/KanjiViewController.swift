//
//  KanjiViewController.swift
//  MyKanji
//
//  Created by Sivan.Payyadakath on 2019/05/27.
//  Copyright © 2019 Sivan.Payyadakath. All rights reserved.
//

import UIKit

class KanjiViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var meaningResult: UILabel!
    @IBOutlet weak var kunLabel: UILabel!
    @IBOutlet weak var kunResult: UILabel!
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var onResult: UILabel!
    @IBOutlet weak var levelUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meaningLabel.isHidden = true
        meaningResult.isHidden = true
        kunLabel.isHidden = true
        kunResult.isHidden = true
        onLabel.isHidden = true
        onResult.isHidden = true
        levelUpButton.isHidden = true
        // Do any additional setup after loading the view.
    }
 
    func displayInView(data: KanjiModel?, error: Error?){

        DispatchQueue.main.async {
            self.meaningLabel.isHidden = false
            self.meaningResult.isHidden = false
            self.kunLabel.isHidden = false
            self.kunResult.isHidden = false
            self.onLabel.isHidden = false
            self.onResult.isHidden = false
            self.levelUpButton.isHidden = false
            self.meaningResult.text = data!.meanings.joined(separator: ", ")
            self.kunResult.text = data!.kun.joined(separator: ", ")
            self.onResult.text = data!.on.joined(separator: ", ")
            
        }
        }

    
    func searchKanji(kanjiEntered: String){
        let str = kanjiEntered.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlPath = "https://kanjiapi.dev/v1/kanji/" + str!
        guard let url =  URL(string: urlPath) else {return}
        
        kanjiAPI.getKanjiResponse(url: url, completionHandler: displayInView(data:error:) )
    }
}

extension KanjiViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newText = textField.text, textField.text != ""{
            searchKanji(kanjiEntered: newText)

        }
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        meaningLabel.isHidden = true
        meaningResult.isHidden = true
        kunLabel.isHidden = true
        kunResult.isHidden = true
        onLabel.isHidden = true
        onResult.isHidden = true
    }
}
