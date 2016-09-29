

Pod::Spec.new do |s|


  s.name         = "ASPageViewController"
  s.version      = "0.0.1"
  s.summary      = "A view controller is used to implement gestures sliding page and click on the page."

  s.description  = <<-DESC 
Used to display content pages, can slide through gestures to switch pages, also can part by clicking on the title to switch pages
                   DESC

  s.homepage     = "https://github.com/zhanghongdou/ASPageViewController-OC"


  s.license      = "MIT"


  s.author             = { "HONG DOU ZHANG" => "1914144764@qq.com" }

  s.platform     = :ios, "7.0"


  s.source       = { :git => "https://github.com/zhanghongdou/ASPageViewController-OC.git", :tag => s.version.to_s }



  s.source_files  = "ASPageViewController", "ASPageViewController/**/*.{h,m}"


  s.requires_arc = true

end
