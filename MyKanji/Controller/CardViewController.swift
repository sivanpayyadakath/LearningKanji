//
//  CardViewController.swift
//  MyKanji
//
//  Created by Sivan.Payyadakath on 2019/05/28.
//  Copyright © 2019 Sivan.Payyadakath. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    var level: Int?
    @IBOutlet weak var collectionView: UICollectionView!
    var kanji: KanjiModel?
    var kanjiSet : [String] = []
    var str: String?
    
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var kuLabel: UILabel!
    @IBOutlet weak var kuLabelMeaning: UILabel!
    @IBOutlet weak var onLabel: UILabel!
    @IBOutlet weak var onLabelMeaning: UILabel!
    
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(nextKanji(sender:)) )
//        let leftSwipe = UIGestureRecognizer(target: self, action: #selector(nextKanji))
        leftSwipe.direction = .left
        
        self.collectionView.addGestureRecognizer(leftSwipe)
        
        meaningLabel.isHidden = true
        kuLabel.isHidden = true
        kuLabelMeaning.isHidden = true
        onLabel.isHidden = true
        onLabelMeaning.isHidden = true

        str = kanjiSet.first!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlPath = "https://kanjiapi.dev/v1/kanji/\(str!)"
        guard let url =  URL(string: urlPath) else {return}
        kanjiAPI.getKanjiResponse(url: url, completionHandler: displayInView(data:error:) )
        print("helloooooo")
    }
    

    func displayInView(data: KanjiModel?, error: Error?){

        DispatchQueue.main.async {
            self.meaningLabel.isHidden = false
            self.kuLabel.isHidden = false
            self.kuLabelMeaning.isHidden = false
            self.onLabel.isHidden = false
            self.onLabelMeaning.isHidden = false
            self.meaningLabel.text = data!.meanings.joined(separator: ", ")
            self.kuLabelMeaning.text = data!.kun.joined(separator: ", ")
            self.onLabelMeaning.text = data!.on.joined(separator: ", ")

        }
    }
    
    @objc private func nextKanji(sender: UISwipeGestureRecognizer){
        UIView.animate(withDuration: 2, delay: 2, options: .transitionFlipFromLeft, animations: {
            self.meaningLabel.isHidden = true
            self.kuLabel.isHidden = true
            self.kuLabelMeaning.isHidden = true
            self.onLabel.isHidden = true
            self.onLabelMeaning.isHidden = true
 
            self.kanjiSet.remove(at: 0)
            self.str = self.kanjiSet.first!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let urlPath = "https://kanjiapi.dev/v1/kanji/\(self.str!)"
            guard let url =  URL(string: urlPath) else {return}
            kanjiAPI.getKanjiResponse(url: url, completionHandler: self.displayInView(data:error:) )
            self.collectionView.reloadData()
            
        }, completion: nil)
//        let cell = sender.view as! KanjiLevelCollectionViewCell
    }
}


extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! KanjiLevelCollectionViewCell
        cell.kanjiLabel.text = kanjiSet[indexPath.row]
        
        return cell
    }
}


