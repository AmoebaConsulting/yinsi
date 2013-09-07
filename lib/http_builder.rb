class HttpBuilder
  class Response
    attr_reader :status_code, :status_description, :info

    def initialize(json={}, options={})
      @invalid = !!options[:invalid]
      @status_code = options[:status_code]
      @status_description = options[:status_description]
      @json = json
      @info = @json['info'] || options[:info] || ''
    end

    def data
      @json['data']
    end

    def success?
      !!@json['success']
    end

    def !
      self.success?
    end

    def[](key)
      @json['data'][key]
    end

    # Valid / invalid in this context refers to the JSON response itself
    def invalid?
      @invalid
    end

    def valid?
      !invalid?
    end

    def to_str
      "Response [[ success?: #{self.success?}, valid?: #{self.valid?}, info: '#{self.info}', data: #{self.data} ]]"
    end
  end

  attr_accessor :verb, :data

  def initialize
    @headers = api_headers
    @errors = {}
    @data = {}
    @verb = :get
  end

  def header(v={}); @headers.merge!(v); end

  # the first error response found is called, defaulting to the default error callback, and if
  # no error handler is found, an alert is automatically generated
  def error(v=nil, &block)
    if v
      @errors[v] = block
    else
      @default_error_callback = block
    end
  end
  def response(&block); @callback = block; end # this callback is _always_ called, error or no

  def build(url)
    opt_args = { headers: @headers }
    opt_args[:payload] = encode_json if !@data.empty?

    BW::HTTP.send(@verb, url, opt_args) do |response|
      if response.status_code.nil?
        yinsi_response = Response.new({}, info: response.error_message)
      else
        yinsi_response = decode_json(response)
      end

      @callback.call(yinsi_response) if @callback

      error_handled = false
      if !response.ok? || yinsi_response.invalid? # If we have an invalid response (non-200) or a JSON parse error
        @errors.each do |code_or_regex, handler|
          if code_or_regex.is_a?(Integer)
            if response.status_code == code_or_regex
              handler.call(yinsi_response) unless error_handled
              error_handled = true
            end
          else
            if response.status_code.to_s.match(code_or_regex)
              handler.call(yinsi_response) unless error_handled
              error_handled = true
            end
          end
        end
        if !error_handled
          if @default_error_callback
            @default_error_callback.call(yinsi_response)
          elsif !yinsi_response.info.empty?
            App.alert(yinsi_response.info)
          else
            App.alert("Unknown server error occurred")
          end
        end
      end
    end
  end

  private

  def api_headers
    headers = { 'Content-Type' => 'application/json' }

    if User.current
      headers["Authorization"] = "Token token=\"#{User.current.auth_token}\""
    end

    headers
  end

  def encode_json
    BW::JSON.generate(@data)
  end

  def decode_json(response)
    begin
      return Response.new(BW::JSON.parse(response.body.to_str),
                          status_code: response.status_code,
                          status_description: response.status_description)
    rescue
      return Response.new({}, invalid: true,
                          status_code: response.status_code,
                          status_description: response.status_description,
                          info: "Error decoding data from server, try again")
    end
  end
end