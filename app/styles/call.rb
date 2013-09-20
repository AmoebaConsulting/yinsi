Teacup::Stylesheet.new :call do
  import :application

  margin = 20

  style :username, extends: :big_input_dark,
    placeholder: "Enter user to call...",
    returnKeyType: :go,
    height: 50,
    width: "100% - #{margin*2}",
    left: margin,
    top: margin

  style :call_time,
    constraints: [constrain_below(:username, 20), :full_width, constrain_height(50)],
    backgroundColor: :clear.uicolor,
    font: :system.uifont(48),
    textAlignment: :center,
    textColor: @blackish,
    text: "0:00",
    hidden: true

  style :challenge_text,
    constraints: [constrain_below(:call_time, 20), :full_width, constrain_height(100)],
    left: margin,
    backgroundColor: :clear.uicolor,
    hidden: true

  style :call_button, extends: :big_button,
    title: "Call",
    font: :bold.uifont(24),
    constraints: [:centered,
                  constrain_height(60),
                  constrain(:width).equals(:superview, :width).minus(40),
                  constrain(:bottom).equals(:superview, :bottom).minus(20)]

  # Subviews of challenge_text:
  style :challenge_text_title,
    constraints: [:full_width, :top, constrain_height(15)],
    backgroundColor: :clear.uicolor,
    font: :system.uifont(14),
    textAlignment: :center,
    textColor: @blackish,
    text: "Compare with partner:"

  style :challenge_text_words,
    height: 75,
    constraints: [:bottom, :full_width],
    backgroundColor: @green_dark,
    text: "Your\n Mother",
    font: :system.uifont(30),
    textAlignment: :center,
    textColor: @clouds,
    lineBreakMode: NSLineBreakByWordWrapping,
    numberOfLines: 0,

end