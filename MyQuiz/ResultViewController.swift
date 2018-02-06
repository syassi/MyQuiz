//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by Mao Nishi on 2017/10/22.
//  Copyright © 2017年 Mao Nishi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel! // 正解率ラベル

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 問題数を取得する
        
        //let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        // 表示した問題数を取得する (追加)
        let questionCount =
            QuestionDataManager.sharedInstance.dispQuestionCount
        // 正解数を取得する
        var correctCount: Int = 0
        // 正解数を計算する
        for questionData in
            QuestionDataManager.sharedInstance.questionDataArray {
                if questionData.isCorrect() {
                    // 正解数を増やす
                    correctCount += 1
                }
        }
        // 正解率を計算する
        let correctPercent: Float =
            (Float(correctCount) / Float(questionCount)) * 100
        // 正解率を小数第一位まで計算して画面に反映する
        correctPercentLabel.text =
            String(format: "%.1f", correctPercent) + "%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
