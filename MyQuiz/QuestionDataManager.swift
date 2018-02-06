//
//  QuestionData.swift
//  MyQuiz
//
//  Created by Mao Nishi on 2017/10/22.
//  Copyright © 2017年 Mao Nishi. All rights reserved.
//

import Foundation

class QuestionData {
    // 問題文
    var question: String

    // 選択肢1
    var answer1: String
    // 選択肢2
    var answer2: String
    // 選択肢3
    var answer3: String
    // 選択肢4
    var answer4: String

    // 正解の番号
    var correctAnswerNumber: Int

    // ユーザが選択した選択肢の番号
    var userChoiceAnswerNumber: Int?

    // 問題文の番号
    var questionNo: Int = 0

    // クラスが生成された時の処理
    init(questionSourceDataArray: [String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }

    // ユーザが選択した答えが正解かどうか判定する
    func isCorrect() -> Bool {
        // 答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiceAnswerNumber {
            // 正解
            return true
        }
        // 不正解
        return false
    }
}

// クイズデータ全般の管理と生成を管理するクラス
class QuestionDataManager {

    // シングルトンのオブジェクトを生成
    static let sharedInstance = QuestionDataManager()

    // 問題を格納するための配列
    var questionDataArray = [QuestionData]()

    // 全問題を格納する配列 (追加)
    var allQuestionDataArray = [QuestionData]()
    
    // 過去の番号を保存する配列 (追加)
    var questionNoArray = [Int]()
    
    // 現在の問題のインデックス
    var nowQuestionIndex = 0
    
    // 表示する問題数　(追加)
    let dispQuestionCount:UInt32 = 3

    // 初期化処理
    private init() {
        // シングルトンであることを保証するためにprivateで宣言しておく
    }

    // 問題文の読み込み処理
    func loadQuestion() {
        // 格納済みの問題文であればいったん削除しておく
        questionDataArray.removeAll()
        // 現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        allQuestionDataArray.removeAll()
        

        // csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            // csvファイルなし
            print("csvファイルが存在しません")
            return
        }

        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            // csvデータを1行ずつ読み込む
            csvStringData.enumerateLines { (line, stop) in
                // カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                // 問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                // 問題を追加
                self.allQuestionDataArray.append(questionData)
                // 問題番号を設定
                questionData.questionNo = self.allQuestionDataArray.count
            }
        } catch let error {
            print("csvファイル読み込みエラーが発生しました\(error)")
            return
        }
    }

    // 次の問題を取り出す
    func nextQuestion() -> QuestionData? {
      //  if nowQuestionIndex < questionDataArray.count {
    
        //　指定問題数まで問題を表示する (変更)
        if nowQuestionIndex < dispQuestionCount {
            //乱数を取得　(追加)
            var random = Int(arc4random_uniform((UInt32)(allQuestionDataArray.count)))
            
            //過去の出題とデータが同じ場合
            while questionNoArray.index(of: random) != nil {
                //もう一度、乱数を取る
                random = Int(arc4random_uniform((UInt32)(allQuestionDataArray.count)))
            }
            
        
            let nextQuestion = allQuestionDataArray[random]
            //問題を保持する
            questionDataArray.append(nextQuestion)
            questionNoArray.append(random)
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }


}
