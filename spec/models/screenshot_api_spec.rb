require 'rails_helper'



describe ScreenshotAPI do
  # Binary strings must be converted to binary
  # with 'string'.b to compare with image
  let(:jpeg_encoding) { "\xff\xd8\xff\xe0".b }

  # URL used only when VCR yaml files not present in
  # spec/vcr
  # 
  # Each file in spec/vcr/screenshot_api refers to
  # a response for a test
  let(:url) { "http://localhost:3000" }


  describe '#get' do
    it 'returns a JPEG image' do
      VCR.use_cassette('screenshot_api/get') do
        response = ScreenshotAPI.get(url)
        expect(response.body[0, 4]).to eq(jpeg_encoding)
      end
    end
  end


  describe '#get_base64' do
    it 'returns a base64 encoded image' do
      VCR.use_cassette('screenshot_api/get_base64') do
        response = ScreenshotAPI.get_base64(url)
        expect { Base64.strict_decode64(response.body) }.to_not raise_error
      end
    end
  end


  describe '#get_image_src' do
    it 'returns a base64 encoded string suitable to insert into an HTML img src' do
      VCR.use_cassette('screenshot_api/get_image_src') do
        response = ScreenshotAPI.get_image_src(url)
        response.gsub!('data:image/jpeg;base64,', '')
        expect { Base64.strict_decode64(response.body) }.to_not raise_error
      end
    end
  end


  describe '#get_image' do
    it 'returns a JPEG image' do
      VCR.use_cassette('screenshot_api/get_image') do
        response = ScreenshotAPI.get_image(url)
        expect(response.body[0, 4]).to eq(jpeg_encoding)
      end
    end
  end
end




