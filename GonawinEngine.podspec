Pod::Spec.new do |spec|
    spec.name = 'GonawinEngine'
    spec.version = '0.10'
    spec.summary = 'Gonawin Engine for iOS'
    spec.homepage = 'https://github.com/taironas/gonawin-engine-ios'
    spec.license = { :type => 'MIT', :file => 'LICENSE.md' }
    spec.authors = { 'Remy Jourde' => 'remy.jourde@gmail.com' }
    spec.social_media_url = 'https://twitter.com/gonawin_app'

    spec.ios.deployment_target = '10.0'
    spec.requires_arc = true

    spec.source = { :git => 'https://github.com/taironas/gonawin-engine-ios.git', :tag => 'v0.10' }
    spec.source_files = 'GonawinEngine/**/*.swift'

    spec.dependency "Moya/RxSwift", :git => "https://github.com/Moya/Moya", :tag => "8.0.0-beta.1"
    spec.dependency "RxSwift", :git => "https://github.com/ReactiveX/RxSwift", :tag => "3.0.0-beta.1"
    spec.dependency "SwiftyJSON", :git => "https://github.com/IBM-Swift/SwiftyJSON.git"
end
