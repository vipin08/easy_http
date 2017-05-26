require 'easy_http/request/connection_adapter'

    module Easy_http_Request
        class Request
            include Send_request

            def initialize(http_method, url ,option = {})
              raise ArgumentError, 'Http Method Not Found!' unless !http_method.nil?
              raise ArgumentError, 'URL Not Found!' unless !url.nil?
              @http_method = http_method
              @option = option
              @url = url
            end

            def connect
              response =  Send_request::Connection_Adapter.connect(@http_method,@url,@option)
            end
        end
    end
