Teacup::Stylesheet.new :application do
  @green = "#A5E200".to_color
  @green_medium = "#89BB00".to_color
  @green_dark = "#5F7C1E".to_color

  @grey = "#D7DBDD".to_color
  @grey_medium = "#979E9F".to_color
  @grey_dark = "#424C4D".to_color

  @blackish = "#333B3D".to_color
  @white = "#FFFFFF".to_color
  @clouds = "#ECF0F1".to_color

  style :root,
    #backgroundColor: @green_medium
    background_gradient: {
      top: :black.uicolor,
      bottom: "#403942".uicolor
    }

  style :basic_input,
    borderStyle: :none,
    autocorrectionType: UITextAutocorrectionTypeNo

  style :big_input, extends: :basic_input,
    height: 60,
    backgroundColor: @grey,
    font: :system.uifont(30),
    contentVerticalAlignment: UIControlContentVerticalAlignmentCenter,
    textAlignment: :center,
    textColor: @blackish,
    placeholderFont: :italic.uifont(30),
    placeholderColor: @white,
    layer: {
      cornerRadius: 5
    }

  style :big_input_dark, extends: :big_input,
    backgroundColor: @green,
    textColor: @white,
    placeholderColor: @white.colorWithAlphaComponent(0.5)

  style :big_button,
    buttonColor: @grey_medium,
    shadowColor: @grey_dark,
    shadowHeight: 3,
    titleColor: @blackish,
    cornerRadius: 5

  # Works better on green_medium backgrounds
  style :big_button_dark, extends: :big_button,
    buttonColor: @grey_dark,
    shadowColor: @blackish,
    titleColor: @clouds

end