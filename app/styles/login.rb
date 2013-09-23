Teacup::Stylesheet.new :login do
  import :application

  style :title,
    text: 'SUBSPEAK',
    numberOfLines: 1,
    font: :bold.uifont(24),
    textColor: @green_logo,
    textAlignment: :center,
    backgroundColor: :clear,

    top: 50,
    width: '100% - 40',
    left: 20,
    height: 40

  style :username, extends: :big_input,
    placeholder: "USERNAME",
    returnKeyType: :next,

    width: 260,
    #left: 0,
    left: -260,
    top: 124

  style :password, extends: :big_input,
    placeholder: "PASSWORD",
    returnKeyType: :go,
    secure: true,

    width: 260,
    #left: 0,
    left: -260,
    top: 188


  style :login_button, extends: :big_button,
    title: "CONNECT",
    setAlpha: 0.25,
    enabled: false,

    left: 140,
    #top: 248,
    top: 368,
    width: 120,
    height: 34

  style :register_button, extends: :big_button_green,
    title: "REGISTER",
    contentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft,
    padding: { right: 10, left: 10 },

    #left: 145,
    left: 320,
    top: 400,
    #width: 315,
    width: 175,
    height: 34

end
