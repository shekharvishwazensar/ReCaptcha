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
    
    private static let bundle: Bundle = {
        let bundle = Bundle(for: ReCaptchaViewModel.self)
        guard let cocoapodsBundle = bundle
                .path(forResource: "GoogleReCaptcha", ofType: "bundle")
                .flatMap(Bundle.init(path:)) else {
                    return bundle
                }
        
        return cocoapodsBundle
    }()
    
    var html: String {

        guard let fileURL = ReCaptchaViewModel.bundle.url(forResource: "recaptcha", withExtension: "html") else {
            assertionFailure("Unable to find the resource.")
            return ""
        }
        
        let filePath = try! String(contentsOf: fileURL, encoding: .utf8)
        return parse(filePath, with: ["siteKey": siteKey])
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

