# Captcha View

In your podfile include: pod 'ReCaptcha', :git => 'https://github.com/shekharvishwazensar/ReCaptcha'

# ReCaptcha 
- Create you sitekey from https://www.google.com/recaptcha/
    
    
    let viewModel = ReCaptchaViewModel(
        siteKey: "YOURSITEKEY",
        url: URL(string: "URL")!
    )

    viewModel.delegate = self

    let viewContoller = ReCaptchaViewController(viewModel: viewModel)
    let navigationController = UINavigationController(rootViewController: viewContoller)
    present(navigationController, animated: true)

##ReCaptchaViewModelDelegate
- Get token when captcha is verified

    func didSolveCaptcha(token: String) {
        print("Token: \(token)")
    }

# Custom Captcha View 
 
  Assign CustomCaptchaView to UIView
  
  // call generateCaptcha method to generate the captcha and pass captcha type in Parameter
  captchaView.generateCaptcha(captchaType: .numeric)

  Can set some property 
  captchaLength :-  set captcha length default value is 5
  kerningSpace :-  set kern space default value is 0
  applyShadow :-  default value is true 
  isStrikeThrough :-  default value is true 
