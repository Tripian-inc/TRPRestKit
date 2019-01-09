Pod::Spec.new do |s|

s.name = 'TRPRestKit'
s.version = '1.1.0'
s.summary = 'POD_DESCRIPTION'
s.homepage = 'https://github.com/necatievrenyasar'

s.license =  s.license = { :type => 'MIT', :file => '/Users/evrenyasar/Xcode/TRPRestKit/LICENSE' }
s.author = { 'Evren Yaşar' => 'necatievren@gmail.com' }
s.platform = :ios, '10.0'
# s.source = { :path => '*', :tag => s.version.to_s }
s.source = { :git => 'https://necatievrenyasar:N-pibolu13@github.com/Tripian-inc/TRPRestKit.git', :tag => '1.1.5' }
s.source_files = 'TRPRestKit/**/**/**/**/**/*.{h,m,swift,xcdatamodeld}'
s.exclude_files = "TRPRestKit/*.plist"
# s.source_files = 'TRPRestKit'
s.frameworks = 'UIKit'
s.dependency 'TRPFoundationKit'
s.swift_version = "4.2"
s.requires_arc = true
end