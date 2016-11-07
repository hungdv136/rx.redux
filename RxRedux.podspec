Pod::Spec.new do |s|
  s.name             = 'RxRedux'
  s.version          = '0.1.0'
  s.summary          = 'Redux using ReactiveX'


  s.description      = <<-DESC
  Redux is a Redux-like implementation of the unidirectional data flow architecture in Swift.
  It embraces a unidirectional data flow that only allows state mutations through declarative actions.
  This library base on ReSwift - Benjamin Encz
                       DESC

  s.homepage         = 'https://github.com/hungdv136/rx.redux'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hung Dinh' => 'hungdv136@gmail.com' }
  s.source           = { :git => 'https://github.com/hungdv136/rx.redux.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hungdv136'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Redux/**/*.swift'

  s.dependency 'RxSwift', '~> 3.0'
  s.dependency 'RxCocoa', '~> 3.0'
end
