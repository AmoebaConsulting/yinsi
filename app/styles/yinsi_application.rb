Teacup::Stylesheet.new :yinsi_application do
  @green = "#A5E200".to_color
  @green_medium = "#89BB00".to_color
  @green_dark = "#5F7C1E".to_color

  @clouds = "#ECF0F1".to_color
  @grey_light = "#979E9F".to_color
  @grey = "#424C4D".to_color
  @grey_dark = "#333B3D".to_color

  @white = "#FFFFFF".to_color


  style :root,
    backgroundColor: @green_medium

  style :basic_input,
    borderStyle: :none,
    autocorrectionType: UITextAutocorrectionTypeNo

  style :big_input, extends: :basic_input,
    height: 60,
    backgroundColor: @green,
    font: :system.uifont(30),
    contentVerticalAlignment: UIControlContentVerticalAlignmentCenter,
    textAlignment: :center,
    textColor: @clouds,
    placeholderFont: :italic.uifont(30),
    placeholderColor: @clouds.uicolor(0.75),
    layer: {
      cornerRadius: 5
    }

  style :big_button,
    buttonColor: @grey_light,
    shadowColor: @grey,
    shadowHeight: 3,
    titleColor: @grey_dark,
    cornerRadius: 5

  # Works better on green_medium backgrounds
  style :big_button_dark, extends: :big_button,
    buttonColor: @grey,
    shadowColor: @grey_dark,
    titleColor: @clouds

end