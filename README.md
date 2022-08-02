# ReCaptcha

In your podfile include: pod 'ReCaptcha', :git => 'https://github.com/shekharvishwazensar/ReCaptcha'

# Usage
- Create you sitekey from https://www.google.com/recaptcha/
    
    
    let viewModel = ReCaptchaViewModel(
        siteKey: "YOURSITEKEY",
        url: URL(string: "URL")!
    )

    viewModel.delegate = self

    let viewContoller = ReCaptchaViewController(viewModel: viewModel)
    let navigationController = UINavigationController(rootViewController: viewContoller)
    present(navigationController, animated: true)

#ReCaptchaViewModelDelegate
- Get token when captcha is verified

    func didSolveCaptcha(token: String) {
        print("Token: \(token)")
    }
