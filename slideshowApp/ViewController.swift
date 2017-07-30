//
//  ViewController.swift
//  slideshowApp
//
//  Created by 池内佳史 on 2017/07/25.
//  Copyright © 2017年 池内佳史. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playBotton: UIButton!
   

    var imageNages = [
        "IMG_4048.jpg", "IMG_4202.jpg", "IMG_4854.jpg"
    ]
    var imageIndex: Int = 0
    var timer: Timer!
    var timer_sec: Float = 0
  
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageView.image = UIImage(named: imageNages[imageIndex])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    func updateTimer(timer: Timer) {
        self.timer_sec += 2.0
        imageView.image = UIImage(named: imageNages[imageIndex])
        if imageNages.count - 1 <= imageIndex {
            imageIndex = 0                       //最後のview表示後タップするとimageNages 0のViewに戻る
        }
        else {
            imageIndex += 1                      //配列にあるviewを＋１ずつ入れ替える
            // sldeshow実行時backbotton無効にする
            backButton.isEnabled = false
            
        }
          print("image: \(imageIndex)")
        
    }
    
    @IBAction func forward(_ sender: Any) {
        
        
        if imageNages.count - 1 <= imageIndex {
            imageIndex = 0                       //最後のview表示後タップするとimageNages 0のViewに戻る
        }
        else {
            imageIndex += 1                      //配列にあるviewを＋１ずつ入れ替える
        }
        imageView.image = UIImage(named: imageNages[imageIndex])
        print("forward: \(imageIndex)")
    
    }
    @IBAction func back(_ sender: Any) {
        
        
        if imageIndex <= 0 {
            imageIndex = 2                      //最初のview表示後タップするとimageNages ２のViewに戻る
        } else {
            imageIndex -= 1                      //配列にあるviewを-１ずつ入れ替える
        }
        
        imageView.image = UIImage(named: imageNages[imageIndex])
        print("back: \(imageIndex)")
    }

    @IBAction func play(_ sender: Any) {
       
        if self.timer == nil {
        self.timer = Timer.scheduledTimer(timeInterval: 2.0,
              target: self,
              selector: #selector(updateTimer),
              userInfo: nil,
              repeats: true)
            
            //ボタンのタイトル変更.
            playBotton.setTitle("停止", for: .normal)
            
        } else {
            //停止ボタンを有効にする
             backButton.isEnabled = true
             //ボタンのタイトルを変更
             playBotton.setTitle("再生", for: .normal)
            if self.timer != nil {
                self.timer.invalidate()   // 現在のタイマーを破棄する
                self.timer = nil          // startTimer() の timer == nil で判断するために、 timer = nil としておく
            }
        
        imageView.image = UIImage(named: imageNages[imageIndex])
        print("play: \(imageIndex)")
     }
    
}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segueから遷移先のExpansionViewControllerを取得する
        let expansionViewController:ExpansionViewController = segue.destination as! ExpansionViewController
        expansionViewController.image = UIImage(named: imageNages[imageIndex])
        
        
    }
    
    //他の画面からsegueを使って戻ってきた時に呼ばれる
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    ///画像タップ時呼ばれるアクション
    /// - parameter segue: UITapGestureRecognizer
    @IBAction func Tapimage(_ segue: UITapGestureRecognizer) {
        performSegue(withIdentifier: "segueExpansion", sender: self)
        
    }
    
        
    }

    
    
    

 


