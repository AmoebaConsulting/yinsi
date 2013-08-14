module YinsiHelpers
  extend self
  
  def self.included(base)
    base.send :extend, self
  end

  # Lookup a variable from the main application teacup stylehseet
  def stylesheet_var(name)
    # We need to hit a fake query to Teacup::Stylesheet to ensure it has parsed it, or
    # it's possible that it has not yet been loaded.
    @query_completed ||= begin
      Teacup::Stylesheet[:yinsi_application].query(:dummy)
      true
    end
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

  def api_headers(others = {})
    headers = { 'Content-Type' => 'application/json' }
    headers.merge(others)
  end

  def font_awesome_tab_icon(icon_name)
    FontAwesomeKit.imageForIcon(FontAwesomeKit.allIcons["FAKIcon#{icon_name.to_s.sub('-','_').camelize.sub('Icon','')}"], imageSize: CGSizeMake(30,30), fontSize: 29, attributes: nil)
  end

  def dismiss_keyboard_on_tap
    self.view.addGestureRecognizer(UITapGestureRecognizer.alloc.initWithTarget(self, action: 'dismissKeyboard'))
  end
end
