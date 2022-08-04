Pod::Spec.new do |s|
  s.name             = 'ReCaptcha'
  s.version          = '1.0.0'
  s.summary          = 'ReCaptcha is used for Google reCaptcha V2'

  s.description      = "This library contains Google reCaptcha V2 with invisible reCaptcha badge"

  s.homepage         = 'https://www.zensar.com/'
  s.license          = 'MIT'
  s.author           = { 'shekharvishwazensar' => 'shekhar.vishwakarma@zensar.com' }
  s.source           = {
    :git => 'https://github.com/shekharvishwazensar/ReCaptcha',
    :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.platform     = :ios, '11.0'
  s.requires_arc = true
  s.default_subspec = 'All'
  s.swift_versions = '5.0'

  s.subspec "All" do |sp|
    # Internal dependencies
    
    # Third Party Dependencies
   sp.source_files = 'GoogleReCaptcha/**/*.{swift}'
   sp.resource_bundles = {
      'GoogleReCaptcha' => "GoogleReCaptcha/*.html"
    }
  end
end
