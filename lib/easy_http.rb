require 'net/http'
require 'uri'
require 'json'
require 'cgi'

require 'easy_http/request/connection_adapter'
require 'easy_http/request/request_params'


class EASY_HTTP
 include Easy_http_Request
#  attr_accessor :url

 def self.get(url, options = {})
   puts 'hello'
    self.request_type Net::HTTP::Get, url, options
 end

 def self.post(url, options = {})
    self.request_type Net::HTTP::Post, url, options
 end

 def self.put(url, options = {})
    self.request_type Net::HTTP::Put, url, options
 end

 def self.patch(url, options = {})
    self.request_type Net::HTTP::Patch, url, options
 end


 def params_paser
    header_parse(self.params['headers'])
 end

 def body_parse
    body_parser(self.params['body'])
 end

 def header_parse header = {}
   raise ArgumentError, 'Headers must be an object which responds to #to_hash' unless header.respond_to?(:to_hash)
   default_options[:headers].merge!(h.to_hash)
 end

 def body_parser body ={}
   body.to_json
 end

 def self.request_type http_method, url, option
   response =  Easy_http_Request::Request.new(http_method, url, option).connect()
 end

end
