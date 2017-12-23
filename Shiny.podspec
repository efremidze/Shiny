Pod::Spec.new do |s|
  s.name             = 'Shiny'
  s.version          = '1.0.1'
  s.summary          = 'Iridescent Effect View (inspired by Apple Pay Cash)'
  s.homepage         = 'https://github.com/efremidze/Shiny'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'efremidze' => 'efremidzel@hotmail.com' }
  s.source           = { :git => 'https://github.com/efremidze/Shiny.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Sources/*.swift'
end
