module FactoryHelper
  def self.test_image_path(ext=:png)
    Rails.root.join('spec', 'support', "test.#{ext}")
  end


  def self.test_image_base64(ext=:png)
    path = test_image_path(ext)
    image = File.read(path)
    Base64.encode64(image)
  end
end


