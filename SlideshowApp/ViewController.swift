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
    var flag = 0//スライドショー再開フラグ
    var flag2 = 0//最初の状態か判断する
    
    let imageArray = ["sea3.jpg","sea6.jpg","sea4.jpg","sea7.jpg"]//写真の配列
    
    func DisplayImage() {//その時のnumber+1番目の画像をimageviewで表示させる
        let namee = imageArray[number]//表示させたい写真の名前
        
        let image = UIImage(named:namee)
        image1.image = image
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.tapped(_:)))//イベントが入ったUITapGestureRecognizerをインスタンス化
        
        
        self.image1.isUserInteractionEnabled = true//imageviewがタップを検知できるように
        
        self.image1.addGestureRecognizer(tapGesture)//imageviewにイベントを追加
        
        DisplayImage()//最初の画像を表示させる
        
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if timer != nil {//もしタイマーが動いていれば、（スライドショーが進んでいたら）、止める
            self.timer.invalidate()
            self.timer = nil
            flag = 1//スライドショー再開フラグを1にする
            
        }
        self.performSegue(withIdentifier:"mySegue" , sender: nil)//次の画面に遷移できるように準備
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//拡大画面遷移の時に行いたい処理
        if segue.identifier == "mySegue" {
            let expansionViewController:ExpansionViewController = segue.destination as! ExpansionViewController
            
            let namee = imageArray[number]//表示させたい写真の名前
            
            expansionViewController.namee2 = namee//写真の名前を送る
            
        }
    }
    @IBAction func unwind(_ segue:UIStoryboardSegue) {//拡大画面から戻ってきた時
        if (flag == 1) {//拡大画面遷移前に、元々スライドショーをやっていれば、スライドショーを再開する
        
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_timer:)), userInfo: nil, repeats: true)
            flag = 0//flagを0にする
            rreturn.isEnabled = false//戻る進むボタンを押せないように
            forward.isEnabled = false
        }
    }
    
    
    @IBAction func returnaction(_ sender: Any) {
        
        if self.timer == nil {//スライドショーをやっていなければ
        
        if number >= 1 && number <= imageArray.count-1 {
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
        
        if  (number < imageArray.count-1 && flag2 != 0) {
            number += 1//ひとつ先にする
            DisplayImage()//表示
            
            
            
        } else if flag2==0 {//最初の状態で進むをタップしたら
            DisplayImage()//最初の画像を表示
            flag2 = 1//初期フラッグを1にする
            
        } else  {//画像が配列の最後だったら
                number = 0
                DisplayImage()
            }
        
        }
    }
    
    @objc func updateTimer(_timer: Timer) {
    
        
        if (number < imageArray.count-1 ) {
            number += 1//ひとつ先にする
            DisplayImage()//表示
        } else {
            number = 0
            DisplayImage()
        }
    }
    
    
    
    @IBAction func slide(_ sender: Any) {//再生と停止ボタンを押すと、
        
        if self.timer == nil {//スライドショーが動いていなかったら、動かす
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_timer:)), userInfo: nil, repeats: true)
            rreturn.isEnabled = false//スライドショー中は戻るボタンを押せないように
            forward.isEnabled = false//スライドショー中は進むボタンを押せないように
        } else {//スライドショーが動いていたら、止める
            self.timer.invalidate()
            self.timer = nil
            rreturn.isEnabled = true//スライドショーが終わったらボタンを押せるように
            forward.isEnabled = true
        }
    }
    
    

}

