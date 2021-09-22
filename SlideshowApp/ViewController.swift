//
//  ViewController.swift
//  SlideshowApp
//
//  Created by kawachi on 2021/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    // 画像ファイル名の配列
    var imageNames = [
        "panda.jpeg",
        "mamesiba.jpeg",
        "neko.jpeg",
    ]
    
    // 表示中の画像配列番号
    var showIndex = 0
    
    // タイマー
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画像表示
        showImage()
    }
    
    @IBAction func tapPlayButton(_ sender: Any) {
        if timer == nil {
            // スライドショー開始
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            // ボタンをスライドショー開始状態にする
            playButton.setTitle("停止", for: .normal)
            forwardButton.isEnabled = false
            backButton.isEnabled = false
        } else {
            // スライドショー停止
            timer.invalidate()
            timer = nil
            // ボタンをスライドショー停止状態にする
            playButton.setTitle("再生", for: .normal)
            forwardButton.isEnabled = true
            backButton.isEnabled = true
        }
    }
    
    @objc func updateTimer() {
        // showIndexをカウントアップ
        showIndex += 1
        // 最終番号を超えたら0に戻す
        if showIndex >= imageNames.count {
            showIndex = 0
        }
        // 画像表示
        showImage()
    }
    
    @IBAction func tapForwardButton(_ sender: Any) {
        // showIndexをカウントアップ
        showIndex += 1
        // 最終番号を超えたら0に戻す
        if showIndex >= imageNames.count {
            showIndex = 0
        }
        // 画像表示
        showImage()
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        // showIndexをカウントダウン
        showIndex -= 1
        // 最初より前に戻ったら最終番号にする
        if showIndex < 0 {
            showIndex = imageNames.count - 1
        }
        // 画像表示
        showImage()
    }
    
    // showIndexの画像を表示
    func showImage() {
        imageView.image = UIImage(named: imageNames[showIndex])
    }
    
    // 画面遷移時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // スライドショーを停止してから画面遷移する
        if timer != nil {
            // スライドショー停止
            timer.invalidate()
            timer = nil
            // ボタンをスライドショー停止状態にする
            playButton.setTitle("再生", for: .normal)
            forwardButton.isEnabled = true
            backButton.isEnabled = true
        }
        // 表示中の画像を引き継ぎ
        let imageViewController = segue.destination as! ImageViewController
        imageViewController.image = imageView.image
    }
    
    // 画面遷移の戻り用メソッド
    @IBAction func unwind(_ segue:UIStoryboardSegue) {
    }
    
    //@IBAction func tapAction(_ sender: Any) {}
    
    


}

