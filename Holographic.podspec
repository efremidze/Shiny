Pod::Spec.new do |s|
  s.name             = 'Holographic'
  s.version          = '0.0.1'
  s.summary          = 'Holographic Effect (inspired by Apple Pay)'
  s.homepage         = 'https://github.com/efremidze/Confetti'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'efremidze' => 'efremidzel@hotmail.com' }
  s.source           = { :git => 'https://github.com/efremidze/Holographic.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/*.swift'
end
