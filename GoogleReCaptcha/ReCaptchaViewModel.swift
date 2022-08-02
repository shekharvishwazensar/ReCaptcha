//
//  ReCaptchaViewModel.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 02/08/22.
//

import WebKit

public protocol ReCaptchaViewModelDelegate: AnyObject {
    func didSolveCaptcha(token: String)
}

public final class ReCaptchaViewModel: NSObject {
    public weak var delegate: ReCaptchaViewModelDelegate?
    
    var html: String {
        let bundle = Bundle(for: Self.self)        
        guard let filePath = bundle.path(forResource: "recaptcha", ofType: "html") else {
            assertionFailure("Unable to find the file.")
            return ""
        }
        
        let contents = try! String(contentsOfFile: filePath, encoding: .utf8)
        return parse(contents, with: ["siteKey": siteKey])
    }
    
    let siteKey: String
    let url: URL
    
    /// Creates a ReCaptchaViewModel
    /// - Parameters:
    ///   - siteKey: ReCaptcha's site key
    ///   - url: The URL for registered with Google
    public init(siteKey: String, url: URL) {
        self.siteKey = siteKey
        self.url = url
        super.init()
    }
}

// MARK: - WKScriptMessageHandler
extension ReCaptchaViewModel: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController,
                                      didReceive message: WKScriptMessage) {
        guard let token = message.body as? String else {
            assertionFailure("Expected a string")
            return
        }
        
        delegate?.didSolveCaptcha(token: token)
    }
}

private extension ReCaptchaViewModel {
    func parse(_ string: String, with valueMap: [String: String]) -> String {
        var parsedString = string
        
        valueMap.forEach { key, value in
            parsedString = parsedString.replacingOccurrences(
                of: "${\(key)}", with: value
            )
        }
        return parsedString
    }
}

