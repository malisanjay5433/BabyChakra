//
//  ViewController.swift
//  FacebookPlayer
//
//  Created by Sanjay Mali on 28/09/17.
//  Copyright © 2017 Sanjay Mali. All rights reserved.
//
import UIKit
import AVFoundation
class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    var urls = [urlModel]()
    var scrollTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        urls = self.parse()
        navigation()
    }
    private func navigation(){
        self.navigationItem.title = "BabyChakra"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView?.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 70/255, green: 195/255, blue: 217/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = true
        self.collectionView?.backgroundColor = UIColor.init(red:234/255, green:79/255, blue: 101/255, alpha: 1)
    }
    
    private func parse() ->[urlModel]{
        let string_Url = "https://api.myjson.com/bins/qxfi9"
        let url = URL(string:string_Url)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            do {
                let data = try JSONDecoder().decode(VideoModel.self, from: data!)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    for i in data.data.videos{
                        self.urls.append(i)
                    }
                }
                
            } catch let error {
                print(error)
            }
            }.resume()
        return self.urls
    }
    
}
extension HomeViewController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoFrameCell
        let obj = self.urls[indexPath.row]
        let url  = URL(string:obj.videoURL)
        cell.vframe?.layer.cornerRadius = 3.0
        cell.vframe?.layer.masksToBounds = true
        cell.vframe?.videoUrl = url
        cell.vframe?.shouldAutoplay = true
        cell.vframe?.shouldAutoRepeat = true
        cell.vframe?.showsCustomControls = false
        cell.vframe?.isMuted = true
        cell.vframe?.isPlaying  = true
        cell.titleLbl?.text = obj.title
        cell.descriptionLbl?.text = obj.description
        cell.back_View?.layer.cornerRadius = 3.0
        cell.back_View?.layer.masksToBounds = true
        
        var row = indexPath.row
        let recordsToplay = self.urls.count  - 1
        if row < recordsToplay{
            row = row + 1
        }else{
            row = 0
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:collectionView.frame.width, height: 320)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
