//
//  CustomCaptchaViewModel.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 16/08/22.
//

import Foundation

public class CaptchaExpression {
    
    private var question: String = ""
    private var answer: Int = 0
    
    func generateExpression(type: String) -> (question: String, answer: Int) {
        switch Expression(rawValue: type) {
        case .addition:
            generateExpressionForAddtion()
        case .substraction:
            generateExpressionForSubtraction()
        case .multipication:
            generateExpressionForMultipication()
        case .none:
            break
        }
        return (question, answer)
    }
    
    private func generateExpressionForAddtion() {
        let num1 = generateRandomNumber(min: 1, max: 10)
        let num2 = generateRandomNumber(min: 0, max: 10)
        question = "\(num1) + \(num2)"
        answer = num1 + num2
    }
    
    private func generateExpressionForSubtraction() {
        let num1 = generateRandomNumber(min: 1, max: 10)
        let num2 = generateRandomNumber(min: 0, max: num1)
        question = "\(num1) - \(num2)"
        answer = num1 - num2
    }
    
    private func generateExpressionForMultipication() {
        let num1 = generateRandomNumber(min: 1, max: 10)
        let num2 = generateRandomNumber(min: 0, max: 10)
        question = "\(num1) x \(num2)"
        answer = num1 * num2
    }
    
    private func generateRandomNumber(min: Int, max: Int) -> Int{
        return  min == max ? max : Int.random(in: min..<max)
    }
}
