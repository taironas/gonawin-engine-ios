Pod::Spec.new do |spec|
    spec.name = "GonawinEngine"
    spec.version = "0.2.0"
    spec.summary = "Gonawin Engine for iOS"
    spec.homepage = "https://github.com/taironas/gonawin-engine-ios"
    spec.license = { type: 'MIT', file: 'LICENSE.md' }
    spec.authors = { "Remy Jourde" => 'remy.jourde@gmail.com' }
    spec.social_media_url = "https://twitter.com/gonawin_app"

    spec.platform = :ios, "9.0"
    spec.requires_arc = true
    spec.source = { git: "https://github.com/taironas/gonawin-engine-ios.git", tag: "v#{spec.version}", submodules: true }
    spec.source_files = "GonawinEngine/**/*.{h,swift}"

    spec.dependency "Moya/RxSwift", "~> 6.2.0"
    spec.dependency "RxSwift", "~> 2.2.0"
    spec.dependency "SwiftyJSON", "~> 2.3.2"
end