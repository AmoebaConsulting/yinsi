Teacup::Stylesheet.new :application do
  @green_logo = "#A5E200".to_color
  @green_medium = "#89BB00".to_color
  @green_dark = "#5F7C1E".to_color

  @purple = "#b390b6".to_color
  @purple_light = "#eacdff".to_color

  @testColor = BubbleWrap.rgba_color(189, 20, 12, 0.4)

  @green = "#78daa3".to_color
  @green_light = "#d1ffd5".to_color

  @grey = "#D7DBDD".to_color
  @grey_medium = "#979E9F".to_color
  @grey_dark = "#424C4D".to_color

  @blackish = "#333B3D".to_color
  @white = "#FFFFFF".to_color
  @clouds = "#ECF0F1".to_color

  style :root,
    background_gradient: {
      top: :black.uicolor,
      bottom: "#403942".uicolor
    }

  style :basic_input,
    borderStyle: :none,
    autocorrectionType: UITextAutocorrectionTypeNo

  style :big_input, extends: :basic_input,
    height: 40,
    font: :normal.uifont(17),
    contentVerticalAlignment: UIControlContentVerticalAlignmentCenter,
    autocapitalizationType: UITextAutocapitalizationTypeAllCharacters,
    textAlignment: :right,
    placeholderColor: @white.uicolor(0.4),
    padding: { left: 15, right: 15 },
    backgroundColor: @grey_medium,
    textColor: @white.colorWithAlphaComponent(0.5),
    height: 38

  style :big_button,
    backgroundColor: @purple,
    titleColor: @purple_light,
    font: :bold.uifont(17),
    shadow: {
      color: @purple,
      opacity: 0.75,
      radius: 15
    },
    titleShadow: {
      color: :black.uicolor,
      opacity: 0.4,
      radius: 3.0
    }

  style :big_button_green, extends: :big_button,
    backgroundColor: @green,
    titleColor: @green_light,
    shadow: {
      color: @green_light,
      opacity: 0.5,
      radius: 15
    },
    titleShadow: {
      color: "#6a9a80".to_color,
      opacity: 1.0,
      radius: 3.0
    }

end