# ReCaptcha

In your podfile include: pod 'ReCaptcha', :git => 'https://github.com/shekharvishwazensar/ReCaptcha'

# Usage
//https://www.google.com/recaptcha/
    let viewModel = ReCaptchaViewModel(
        siteKey: "YOURSITEKEY",
        url: URL(string: "URL")!
    )

    let viewContoller = ReCaptchaViewController(viewModel: viewModel)
    let navigationController = UINavigationController(rootViewController: viewContoller)
    present(navigationController, animated: true)

#ReCaptchaViewModelDelegate
    didSolveCaptcha(token: String)
