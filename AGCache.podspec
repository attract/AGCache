Pod::Spec.new do |s|
  s.name             = 'AGCache'
  s.version          = '0.1.3'
  s.summary          = 'Small image cache system with resizing on-the-go. '
 
  s.description      = <<-DESC
System allows to download, save to cache and resize images on-the-go! Forget about performance problems!
                       DESC
 
  s.homepage         = 'https://github.com/attract/AGCache'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Stanislav Makushov' => 'stanislav.makushov@gmai.com' }
  s.source           = { :git => 'https://github.com/attract/AGCache.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'ProjectFiles/AGCache/*.swift'
 
end