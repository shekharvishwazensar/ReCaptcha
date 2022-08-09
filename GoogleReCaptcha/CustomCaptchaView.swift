//
//  CustomCaptchaView.swift
//  GoogleReCaptcha
//
//  Created by SV59349 on 05/08/22.
//

import Foundation
import UIKit

@IBDesignable public class CustomCaptchaView: UIView {
    
    // MARK: - UI Components
    @IBOutlet weak var CaptchaLabel: UILabel!
    
    // MARK: - Properties
    var charLength: Int = 5
    var kern: Int = 0
    
    public var text: NSAttributedString? {
        didSet {
            CaptchaLabel.attributedText = text
        }
    }
    
    @IBInspectable public var captchaLength: Int {
        get {
            return charLength
        }
        set {
            charLength = newValue
        }
    }
    
    @IBInspectable public var kerningSpace: Int {
        get {
            return kern
        }
        set {
            kern = newValue
        }
    }
    
    @IBInspectable public var applyShadow: Bool = true
    @IBInspectable public var isStrikethrough: Bool = true
    
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
    private func randomString(length: Int, captchaType: String) -> String {
        return String((0..<length).map{ _ in captchaType.randomElement()! })
    }
    
    var attributedKeys: [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.font: randomFont(), NSAttributedString.Key.foregroundColor: randomColor()]
    }
    
    func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    func randomColor() -> UIColor {
        let colors: [UIColor] = [.magenta, .blue, .black, .cyan, .darkText]
        return colors.randomElement() ?? UIColor.black
    }
    
    func randomFont() -> UIFont {
        let fonts = [UIFont.systemFont(ofSize: 20),
                     UIFont.init(name: "Bradley Hand", size: 25)!,
                     UIFont.init(name: "Chalkboard SE", size: 22)!,
                     UIFont.init(name: "Times New Roman", size: 24)!
        ]
        
        return fonts.randomElement()!
    }
    
    public func generateCaptcha(captchaType: CaptchaType) {
        let captcha = randomString(length: charLength, captchaType: captchaType.selectedCaptcha())
        let attributed = NSMutableAttributedString(string: captcha)
        
        for i in 0...charLength - 1 {
            attributed.addAttributes(attributedKeys, range: NSRange(location: i, length: 1))
        }
        
        if applyShadow {
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.gray
            shadow.shadowBlurRadius = 5
            attributed.addAttribute(NSAttributedString.Key.shadow, value: shadow, range: NSMakeRange(0,attributed.length))
        }
        
        if isStrikethrough {
            attributed.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributed.length))
        }
        
        attributed.addAttribute(NSAttributedString.Key.kern, value: kern, range: NSRange(location: 0, length: charLength))
        
        
        text = attributed
    }
    
    private func loadFromXib() {
        let nib = UINib(nibName: "CustomCaptchaView", bundle: CustomCaptchaView.bundle)
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
    
    private static let bundle: Bundle = {
        let bundle = Bundle(for: CustomCaptchaView.self)
        guard let cocoapodsBundle = bundle
                .path(forResource: "GoogleReCaptcha", ofType: "bundle")
                .flatMap(Bundle.init(path:)) else {
                    return bundle
                }
        
        return cocoapodsBundle
    }()
}

public enum CaptchaType: String {
    case numeric
    case alphaNumeric
    
    func selectedCaptcha() -> String {
        switch self {
        case .numeric:
           return "0123456789"
        case .alphaNumeric:
           return "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ0123456789"
        }
    }
}
