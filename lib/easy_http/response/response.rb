require 'json'
require 'cgi'

module Easy_http_Response
   class Http_response

     @content_type = [
       'text/html',
       'multipart/form-data',
       'message/partial',
       'image/png',
       'audio/mpeg',
       'video/mp4',
       'application/json'
     ]

     def initialize response
       raise ArgumentError, 'invalid response' unless !response.nil?
       @response = response
     end

     def parse_body
       rs_json
     end

     def rs_json
       response = JSON.parse(@response) rescue nil
     end

   end
end
