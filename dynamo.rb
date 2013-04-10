require 'sinatra'
# because we like to party (get xml)
require 'httparty'

get '/' do
  send_file(File.join(settings.public_folder, 'index.html'))
end

get '/connection' do
  content_type 'text/xml', :charset => 'utf-8'
  response = HTTParty.get('http://rmn.memory-life.com/Connect/?msidn=prod')
  response.body
end
