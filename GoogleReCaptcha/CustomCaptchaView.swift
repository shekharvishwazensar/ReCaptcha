//
//  CustomCaptchaView.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 05/08/22.
//

import Foundation
import UIKit

public protocol GeneratedCaptchaDelegate: AnyObject{
    func generatedCaptcha(captcha: String)
}

@IBDesignable public class CustomCaptchaView: UIView {
    
    // MARK: - UI Components
    @IBOutlet weak var CaptchaLabel: UILabel!
    
    // MARK: - Properties
    public weak var delegate: GeneratedCaptchaDelegate?
    
    public var text: NSAttributedString? {
        didSet {
            CaptchaLabel.attributedText = text
        }
    }
    public var textColors: [UIColor] = [.magenta, .blue, .black, .cyan, .darkText]
    public var textFonts: [UIFont]  = [UIFont.systemFont(ofSize: 20)]
    
    @IBInspectable public var captchaLength: Int = 5
    @IBInspectable public var kerningSpace: Int = 0
    @IBInspectable public var applyShadow: Bool = true
    @IBInspectable public var isStrikeThrough: Bool = false
    
    // MARK: - Initializations
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromXib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromXib()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadFromXib()
    }
    
    // MARK: - Methods
    private func loadFromXib() {
        let nib = UINib(nibName: "CustomCaptchaView", bundle: LoadBundle.bundle(view: CustomCaptchaView.self))
        guard let customCaptchaView = nib.instantiate(withOwner: self).first as? UIView else { return }
        addSubview(customCaptchaView)
        
        customCaptchaView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customCaptchaView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            customCaptchaView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            customCaptchaView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            customCaptchaView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
            
        ])
    }
    
    private func randomString(length: Int, captchaType: String) -> String {
        return String((0..<length).map{ _ in captchaType.randomElement()! })
    }
    
    private var attributedKeys: [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: randomFont(), NSAttributedString.Key.foregroundColor: randomColor()]
    }
    
    private func randomColor() -> UIColor {
        return textColors.randomElement() ?? UIColor.black
    }
    
    private func randomFont() -> UIFont {
        return textFonts.randomElement()!
    }
    
    public func generateCaptcha(captchaType: CaptchaType) {
        
        switch captchaType {
        case .expression:
            let randomOperation = randomString(length: 1, captchaType: captchaType.selectedCaptcha())
            let objCaptchaExpression = CaptchaExpression()
            let result = objCaptchaExpression.generateExpression(type: randomOperation)
            captchaLength = result.question.count
            text = generateAttributeString(captcha: result.question)
            delegate?.generatedCaptcha(captcha: "\(result.answer)")
        default:
            let captcha = randomString(length: captchaLength, captchaType: captchaType.selectedCaptcha())
            text = generateAttributeString(captcha: captcha)
            delegate?.generatedCaptcha(captcha: text?.string ?? "")
        }
    }
    
    func generateAttributeString(captcha: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: captcha)
        
        for i in 0...captchaLength - 1 {
            attributed.addAttributes(attributedKeys, range: NSRange(location: i, length: 1))
        }
        
        if applyShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.gray
            shadow.shadowBlurRadius = 5
            attributed.addAttribute(NSAttributedString.Key.shadow, value: shadow, range: NSMakeRange(0,attributed.length))
        }
        
        if isStrikeThrough {
            attributed.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributed.length))
        }
        
        attributed.addAttribute(NSAttributedString.Key.kern, value: kerningSpace, range: NSRange(location: 0, length: captchaLength))
        
        return attributed
    }
    
}
