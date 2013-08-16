class HttpBuilder
  class Response
    def initialize(json={}, options={})
      @invalid = !!options[:invalid]
      @json = json
    end

    def data
      @json['data']
    end

    def success?
      !!@json['success']
    end

    def info
      @json['info'] || ''
    end

    def !
      self.success?
    end

    def[](key)
      @json['data'][key]
    end

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
  def error(v, &block); @errors[v] = block; end
  def response(&block); @callback = block; end

  def build(url)
    opt_args = { headers: @headers }
    opt_args[:payload] = encode_json if !@data.empty?

    BW::HTTP.send(@verb, url, opt_args) do |response|
      if response.status_description.nil?
        App.alert(response.error_message)
      else
        json_response = decode_json(response.body)
        @callback.call(json_response) if @callback
        error_handled = json_response.invalid? # If response is invalid, parsing failed, and we already get an error msg
        if !response.ok?
          @errors.each do |code_or_regex, handler|
            if code_or_regex.is_a?(Integer)
              if response.status_code == code_or_regex
                handler.call(json_response) unless error_handled
                error_handled = true
              end
            else
              if response.status_code.to_s.match(code_or_regex)
                handler.call(json_response) unless error_handled
                error_handled = true
              end
            end
          end
          App.alert("Unknown server error occurred") unless error_handled
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

  def decode_json(json_str)
    begin
      return Response.new(BW::JSON.parse(json_str.to_str))
    rescue
      App.alert("Error decoding data from server, try again")
      return Response.new({}, invalid: true)
    end
  end
end