Teacup::Stylesheet.new :login do
  import :application

  style :title,
    text: 'Yinsi Mobile',
    backgroundColor: :clear,
    numberOfLines: 1,
    font: :bold.uifont(36),
    textColor: @white,
    textAlignment: :center,
    backgroundColor: :clear

  style :username, extends: :big_input_dark,
    placeholder: "Username",
    returnKeyType: :next

  style :password, extends: :big_input_dark,
    placeholder: "Password",
    returnKeyType: :go,
    secure: true

  style :login_button, extends: :big_button_dark,
    height: 60,
    title: "Login",
    font: :bold.uifont(24)

  style :register_button, extends: :big_button_dark,
    height: 40,
    title: "No Account? Register",
    font: :bold.uifont(16)

end
