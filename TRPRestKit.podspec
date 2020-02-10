Pod::Spec.new do |s|
s.name = "TRPRestKit"
s.version = "1.4.4"
s.summary = "Tripian iOS Framework"
s.homepage = "https://www.tripian.com"
s.license =  s.license = { :type => "BSD" }
s.author = { "Tripian" => "necati@tripian.com" }
s.source       = {
    :http => "https://tripian-mobile-sdk.s3.us-east-2.amazonaws.com/trprestkit/1.4.2/TRPRestKit.zip",
    :flatten => true
  }
s.module_name = "TRPRestKit"
s.exclude_files = "Classes/Exclude"
s.ios.deployment_target = "11.0"
s.platform = :ios, "11.0"
s.vendored_frameworks = "TRPRestKit/TRPRestKit.framework"
s.requires_arc = true
s.frameworks = "UIKit"
s.dependency "TRPFoundationKit", "~> 1.5.0"
end
