//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 井上真悠子 on 2020/05/08.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var rreturn: UIButton!
    @IBOutlet weak var playback: UIButton!
    @IBOutlet weak var forward: UIButton!
    
    var number = 0//写真を識別するためのもの
    var timer:Timer!//タイマー
    
    let imageArray = ["sea3.jpg","sea6.JPG","sea4.JPG","sea7.JPG"]//写真の配列
    
    func DisplayImage() {//その時のnumber+1番目の画像をimageviewで表示させる
        let namee = imageArray[number]//表示させたい写真の名前
        
        let image = UIImage(named:namee)
        image1.image = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        number = -1 //初期値を設定
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.tapped(_:)))//イベントが入ったUITapGestureRecognizerをインスタンス化
        
        
        self.image1.isUserInteractionEnabled = true//imageviewがタップを検知できるように
        
        
        
        self.image1.addGestureRecognizer(tapGesture)//imageviewにイベントを追加
        
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            print("タップ")
        }
    }
    
    @IBAction func returnaction(_ sender: Any) {
        
        if self.timer == nil {//スライドショーをやっていなければ
        
        if number >= 1 && number <= imageArray.count-1 && number != -1{
            number -= 1//ひとつ前にして
            DisplayImage()//表示
        } else {//もし、画像が最初のもの、または初期値(-1)だったら
                number = imageArray.count-1//最後に行く
                DisplayImage()
            }
        }
    }
    
    @IBAction func forwardacton(_ sender: Any) {
        
        if self.timer == nil {//スライドショーをやっていなれば
        
        if  (number < imageArray.count-1 && number != -1) {
            number += 1//ひとつ先にする
            DisplayImage()//表示
            print("OK")
            
            
        } else {//画像が配列の最後、またはnumberが初期値(-1)だったら
                number = 0
                DisplayImage()
            }
        
        }
    }
    
    @objc func updateTimer(_timer: Timer) {
    
        
        if (number < imageArray.count-1 && number != -1) {
            number += 1//ひとつ先にする
            DisplayImage()//表示
        } else {
            number = 0
            DisplayImage()
        }
    }
    
    
    
    @IBAction func slide(_ sender: Any) {//再生と停止ボタン
        
        if self.timer == nil {//スライドショーが動いていなかったら、動かす
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateTimer(_timer:)), userInfo: nil, repeats: true)
        } else {//スライドショーが動いていたら、止める
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    

}

