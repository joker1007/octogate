module Octogate
  module TransferRequest
    class Base
      attr_reader :conn

      def initialize(conn)
        @conn = conn
      end

      def do_request(**options)
        raise NotImplementedError
      end
    end

    class GET < Base
      def do_request(**options)
        conn.get do |req|
          req.url options[:url]
          options[:params].each do |k, v|
            req.params[k] = v
          end
        end
      end
    end


    class POST < Base
      def do_request(**options)
        if options[:parameter_type] == :json && options[:params]
          conn.post options[:url] do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = Oj.dump(options[:params])
          end
        else
          conn.post options[:url], options[:params]
        end
      end
    end
  end
end
