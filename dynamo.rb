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

get '/data/:token' do
  content_type 'text/xml', :charset => 'utf-8'
  xml_data_url = "http://api.memory-life.com/v2.0/?method=ml.account.medias.list&token=#{params[:token]}&index=1&length=21&mediaNature=IMAGE"
  response = HTTParty.get(xml_data_url)
  response.body
end
