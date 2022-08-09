//
//  ViewController.swift
//  ReCaptchaExample
//
//  Created by SV59349 on 02/08/22.
//

import UIKit
import GoogleReCaptcha

class ViewController: UIViewController {
    
    @IBOutlet weak var captchaView: CustomCaptchaView!
    
    override func viewWillAppear(_ animated: Bool) {
        captchaView.generateCaptcha(captchaType: .numeric)
    }
    
    override func loadView() {
        super.loadView()
        print("loadview")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnReload(_ sender: UIButton) {
        captchaView.generateCaptcha(captchaType: .alphaNumeric)
        print(captchaView.text?.string)
    }
    
    @IBAction func btngoogleCaptcha(_ sender: UIButton) {
        let viewModel = ReCaptchaViewModel(
            siteKey: "6LeNAj4hAAAAAKZ3MbRcDNk6LjXGKzNdUMHl9dKt",
            url: URL(string: "https://www.google.com")!
        )
        
        viewModel.delegate = self
        
        let viewContoller = ReCaptchaViewController(viewModel: viewModel)
        
        // Optional: present the ReCAPTCHAViewController so you have a navigation bar
        let navigationController = UINavigationController(rootViewController: viewContoller)
        
        // Keep a reference to the View Model so we can be alerted when the user
        // solves the CAPTCHA.
        //        reCaptchaViewModel = viewModel
        
        present(navigationController, animated: true)
    }
}
// MARK: - ReCAPTCHAViewModelDelegate
extension ViewController: ReCaptchaViewModelDelegate {
    func didSolveCaptcha(token: String) {
        print("Token: \(token)")
    }
}


