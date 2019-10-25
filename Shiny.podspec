Pod::Spec.new do |s|
  s.name             = 'Shiny'
  s.version          = '2.0.2'
  s.summary          = 'Iridescent Effect View (inspired by Apple Pay Cash)'
  s.homepage         = 'https://github.com/efremidze/Shiny'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'efremidze' => 'efremidzel@hotmail.com' }
  s.documentation_url = 'https://efremidze.github.io/Shiny/'
  s.source           = { :git => 'https://github.com/efremidze/Shiny.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/*.swift'
end
