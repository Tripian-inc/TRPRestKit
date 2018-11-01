Pod::Spec.new do |s|

s.name = 'TRPRestKit'
s.version = '1.0.5'
s.summary = 'POD_DESCRIPTION'
s.homepage = 'https://github.com/necatievrenyasar'

s.license =  s.license = { :type => 'MIT', :file => '/Users/evrenyasar/XcodeProjects/TRPFoundationKit/LICENSE' }
s.author = { 'Evren Yaşar' => 'necatievren@gmail.com' }
s.platform = :ios, '10.0'
# s.source = { :path => '*', :tag => s.version.to_s }
s.source = { :git => 'https://necatievrenyasar:N-pibolu13@github.com/necatievrenyasar/TRPRestKitLib.git', :tag => '1.0.3' }
s.source_files = 'TRPRestKit/**/**/**/**/**/*'
# s.source_files = 'TRPRestKit'
s.frameworks = 'UIKit'
s.dependency 'TRPFoundationKit'
s.swift_version = "4.2" 
s.requires_arc = true
end