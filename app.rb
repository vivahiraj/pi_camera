# encoding: utf-8
require 'sinatra'
require 'json'

IMG_DIR   = File.dirname(__FILE__) + '/public/img/motion/'
SNAP_SIZE = 12

def get_file_list
  files = Dir.entries(IMG_DIR)
  files.delete("lastsnap.jpg")
  files.delete_if { |x| /.*\.jpg$/ !~ x }
  files.sort! do |a, b|
    File.stat(IMG_DIR + b).mtime.strftime("%Y%m%d%H%M%S") <=>
    File.stat(IMG_DIR + a).mtime.strftime("%Y%m%d%H%M%S")
  end
  files[0..SNAP_SIZE-1]
end

get '/' do
  @files = get_file_list
  haml :index
end

get '/shot' do
  require 'net/http'
  url = URI.parse('http://localhost:8080/0/action/snapshot')
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
  sleep 1
  files = get_file_list
  files.to_json 
end

