require 'net/http'
require 'uri'
require 'json'
require 'cgi'

module Send_request

 class Connection_Adapter
    #  attr_accessor :http_method, :options, :last_response, :redirect, :last_uri, :url

    def self.connect http_method, url, options, limit = 10
        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        puts url
        uri = URI.parse url
        request = http_method.new uri
        # uri = URI(url)
        # params = options if !options.blank?
        # uri.query = URI.encode_www_form(params)
         puts uri
        # res = Net::HTTP.get_response(uri)
        # puts res.body if res.is_a?(Net::HTTPSuccess)


        #
        # req_options = {
        #      use_ssl: uri.scheme == "https",
        # }
        #


        response = Net::HTTP.start(uri.hostname, uri.port) do |http|
          http.request(request)
        end

        case response
        when Net::HTTPSuccess, Net::HTTPRedirection
          response.body
          # OK
        else
          response.value
        end

    end

 end

end
