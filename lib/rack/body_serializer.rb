module Rack
  class BodySerializer
    require_relative "body_serializer/version"
    ACCEPT_KEY = "HTTP_ACCEPT"
    HEADER_KEY = "Content-Type"

    attr_reader :mapping
    private :mapping

    def initialize(stack, mapping, default)
      @stack = stack
      @mapping = mapping
      @default = default
    end

    def call(previous_state)
      @state = previous_state
      @status, @headers, @body = @stack.call(state)

      if accept_type && body.size > 0
        @body = serializer.dump(body)
        headers[HEADER_KEY] = mapping.key(serializer)
      end

      [status, headers, body]
    end

    private def accept_type
      state[ACCEPT_KEY]
    end

    private def serializer
      mapping[accept_type] || @default
    end

    private def stack
      @stack
    end

    private def state
      @state
    end

    private def headers
      @headers
    end

    private def status
      @status
    end

    private def body
      @body
    end
  end
end
