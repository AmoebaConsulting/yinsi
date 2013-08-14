Teacup::Stylesheet.new :yinsi_application do
  @green = "#A5E200".to_color
  @green_medium = "#89BB00".to_color
  @green_ultra_light = "#E6F9B2".to_color
  @green_light = "#D1F963".to_color
  @green_dark = "#5F7C1E".to_color

  @grey = "#424C4D".to_color
  @grey_dark = "#333B3D".to_color

  @white = "#FFFFFF".to_color

  @back_color = :white
  @dark_color = 0x2a487f.uicolor 
  @mid_color = 0x8ea1bc.uicolor

  style :root,
    backgroundColor: @green_medium

  style :big_input,
    height: 60,
    borderStyle: :none,
    autocorrectionType: UITextAutocorrectionTypeNo,
    backgroundColor: @green,
    font: :system.uifont(30),
    contentVerticalAlignment: UIControlContentVerticalAlignmentCenter,
    textAlignment: :center,
    textColor: @white,
    placeholderColor: @white.colorWithAlphaComponent(0.5),
    placeholderFont: :italic.uifont(30),
    layer: {
      cornerRadius: 5
    }

  style :big_button,
    buttonColor: @grey,
    shadowColor: @grey_dark,
    shadowHeight: 3.0,
    titleColor: @white,
    cornerRadius: 6.0
    #layer: {
    #  cornerRadius: 2
    #}

end