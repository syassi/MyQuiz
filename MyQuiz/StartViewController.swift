//
//  StartViewController.swift
//  MyQuiz
//
//  Created by Mao Nishi on 2017/10/22.
//  Copyright © 2017年 Mao Nishi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        // 問題文の読込
        QuestionDataManager.sharedInstance.loadQuestion()

        // 遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // 取得できずに終了
            return
        }

        // 問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 取得できずに終了
            return
        }

        // 問題文のセット
        nextViewController.questionData = questionData
    }

    // タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTitle(_ segue: UIStoryboardSegue) {

    }

}
