module YinsiHelpers

  # Lookup a variable from the main application teacup stylehseet
  def stylesheet_var(name)
    Teacup::Stylesheet[:yinsi_application].instance_variable_get("@#{name.to_s}".to_sym)
  end

  def current_user
    App::Persistence['current_user']
  end

  def parse_json(json_str)
    begin
      return BW::JSON.parse(json_str.to_str)
    rescue
      App.alert("Error decoding data from server, try again")
      return false
    end
  end
  module_function :parse_json

  def api_headers(others = {})
    headers = { 'Content-Type' => 'application/json' }
    headers.merge(others)
  end
  module_function :api_headers
end