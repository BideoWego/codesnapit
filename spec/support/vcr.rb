# spec/support/vcr_setup.rb

VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'

  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock

  # Ignore Capybara JS requests
  c.ignore_request do |request|
    request.uri =~ /__identify__/ ||
    request.uri =~ /hub\/session/
  end
end




