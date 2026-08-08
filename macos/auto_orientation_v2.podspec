Pod::Spec.new do |s|
  s.name             = 'auto_orientation_v2'
  s.version          = '2.4.4'
  s.summary          = 'Set and control device orientation programmatically for Flutter apps on iOS and Android.'
  s.description      = <<-DESC
Set and control device orientation programmatically for Flutter apps on iOS and Android.
                       DESC
  s.homepage         = 'http://rizkyghofur.my.id'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Rizki Abdul Gofur' => 'rizky.abdulghofur@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.platform         = :osx, '10.15'
  s.swift_version    = '5.0'
end
