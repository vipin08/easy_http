require 'easy_http/response/response'

require 'net/http'
require 'uri'
require 'json'
require 'cgi'

module Send_request
  class Connection_Adapter
    # include Easy_http_Response

    #  attr_accessor :http_method, :options, :last_response, :redirect, :last_uri, :url

    def self.connect http_method, url, options, limit = 10
        raise ArgumentError, 'too many HTTP redirects' if limit == 0
        @url =  self.normalize_url url
        uri = URI.parse @url
        if uri.hostname.nil?
           raise URI::InvalidURIError.new("bad URI(no host provided): #{url}")
        end

        request = http_method.new uri
        response = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(request)
        end
        puts response['Content-Type']
        case response
        when Net::HTTPSuccess then self.response_parser response.body
        when Net::HTTPRedirection then self.connect http_method,response['location'],nil, limit - 1
        when Net::HTTPServerException then   response = {'status': '405', 'message': 'Method Not Allowed'}
        else
          response.error!
        end
    end

    def self.normalize_url url
      url = 'http://' + url unless url.match(%r{\A[a-z][a-z0-9+.-]*://}i)
      url
    end

    def self.response_parser response
      p_response =  Easy_http_Response::Http_response.new(response).parse_body
    end

  end
end
