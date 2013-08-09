Teacup::Stylesheet.new :login do
  import :yinsi_application

  v_padding = 10

  style :root,
    backgroundColor: @green_medium

  style :title,
    text: 'Yinsi Mobile',
    backgroundColor: :clear,
    numberOfLines: 1,
    font: :bold.uifont(36),
    textColor: @white,
    textAlignment: :center,
    backgroundColor: :clear

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
    placeholderFont: :italic.uifont(30)

  style :username, extends: :big_input,
    placeholder: "Username",
    returnKeyType: :next

  style :password, extends: :big_input,
    placeholder: "Password",
    returnKeyType: :go,
    secure: true

end
