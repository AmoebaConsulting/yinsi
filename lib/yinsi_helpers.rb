module YinsiHelpers

  # Lookup a variable from the main application teacup stylehseet
  def stylesheet_var(name)
    Teacup::Stylesheet[:yinsi_application].instance_variable_get("@#{name.to_s}".to_sym)
  end
end