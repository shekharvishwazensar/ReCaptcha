//
//  ReCaptchaViewController.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 02/08/22.
//

import UIKit
import WebKit

public final class ReCaptchaViewController: UIViewController {
    // MARK: - UI Components
    private var webView: WKWebView!
    
    // MARK: - Properties
    private let viewModel: ReCaptchaViewModel
    
    // MARK: - Initializations
    public init(viewModel: ReCaptchaViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    public override func loadView() {
        let webViewConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        contentController.add(viewModel, name: "recaptcha")
        webViewConfiguration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didSelectCloseButton)
        )
        
        webView.loadHTMLString(viewModel.html, baseURL: viewModel.url)
    }
    
    // MARK: - Actions
    @IBAction func didSelectCloseButton() {
        dismiss(animated: true)
    }
}

