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
    font: :normal.uifont(17),
    returnKeyType: :next,

    width: 260,
    height: 38,
    left: 0,
    top: 124



  style :password, extends: :big_input,
    placeholder: "PASSWORD",
    returnKeyType: :go,
    font: :normal.uifont(17),
    secure: true,

    width: 260,
    height: 38,
    left: 0,
    top: 188


  style :login_button, extends: :big_button,
    height: 80,
    title: "CONNECT",
    font: :bold.uifont(17),

    left: 145,
    top: 248,
    width: 115,
    height: 34

  style :register_button, extends: :big_button,
    title: "REGISTER",
    font: :bold.uifont(17),
    backgroundColor: @green,
    titleColor: @green_light,
    contentHorizontalAlignment: UIControlContentHorizontalAlignmentLeft,

    left: 145,
    top: 400,
    width: 315,
    height: 34,
    padding: { right: 10, left: 10 }

end
