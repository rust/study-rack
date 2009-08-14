require 'nkf'

module Converter
  class Sjis
    def initialize(app)
      @app = app
    end

    def call(env)
      @env = env
      @status, @header, @body = @app.call(env)
      @body = convert_body(@body)

      [@status, @header, self]
    end

    def close
      @body.close if @body.respond_to? :close
    end

    def <<(str)
      @env["rack.errors"].write(str)
      @env["rack.errors"].flush
    end

    def each
      length = 0
      @body.each { |part|
        length += part.size
        yield part
      }
    end

    def convert_body(body)
      body.map do |part|
        NKF.nkf('-s', part)
      end
    end
  end
end
