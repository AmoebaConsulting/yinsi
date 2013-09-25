Teacup::Stylesheet.new :registration do
  import :application

  #STYLES FOR:
  # :user_label, :user_input
  # :password_label, :password_input
  # :confirm_label, :confirm_input
  # :break_line
  # :email_label, :confirm_input
  # :cancel_button, :register_button


  style :title,
        text: 'SUBSPEAK',
        numberOfLines: 1,
        font: :bold.uifont(20),
        textColor: @green_logo,
        textAlignment: :center,
        backgroundColor: :clear,
        setAlpha: 0.0,

        width: '100% - 20',
        height: 20,
        top: 10,
        left: 20


  style :user_label,
        text: 'USERNAME:',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.6),
        textAlignment: :left,
        backgroundColor: :clear,

        width: 260,
        height: 38,
        top: 40,
        left: 320

  style :user_input, extends: :big_input,
        placeholder: "YOUR CHOICE",
        returnKeyType: :next,

        width: 260,
        top: 75,
        left: -260


  style :password_label,
        text: 'PASSWORD:',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.6),
        textAlignment: :left,
        backgroundColor: :clear,
        #textColor: @white.colorWithAlphaComponent(0.5),

        width: 260,
        height: 38,
        top: 110,
        #left: 10,
        left: 320

  style :password_input, extends: :big_input,
        placeholder: "REQUIRED",
        returnKeyType: :next,
        secure: true,

        width: 260,
        top: 145,
        left: -260

  style :confirm_label,
        text: 'CONFIRM:',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.6),
        textAlignment: :left,
        backgroundColor: :clear,

        width: 260,
        height: 38,
        top: 180,
        left: 320

  style :confirm_input, extends: :big_input,
        placeholder: 'REQUIRED',
        returnKeyType: :next,
        secure: true,

        width: 260,
        top: 215,
        left: -260


  style :break_line,
        text: '- - - - - - - - - - - - - - - - - - - - - - - - -',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.4),
        textAlignment: :center,
        backgroundColor: :clear,
        setAlpha: 0.0,

        width: '100% - 20',
        height: 20,
        top: 260,
        left: 10


  style :email_label,
        text: 'EMAIL:',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.6),
        textAlignment: :left,
        backgroundColor: :clear,

        width: 260,
        height: 38,
        top: 275,
        left: 320

  style :email_input, extends: :big_input,
        placeholder: 'OPTIONAL',
        returnKeyType: :go,

        width: 260,
        top: 310,
        left: -260

  style :email_info,
        text: 'optional and, if provided, this will allow you to reset your password',
        numberOfLines: 2,
        font: :bold.uifont(11),
        textColor: @green_logo,
        textAlignment: :left,
        backgroundColor: :clear,

        width: 240,
        height: 38,
        top: 350,
        left: -240

  style :cancel_button, extends: :big_button,
        title: "<",
        font: :bold.uifont(20),
        contentHorizontalAlignment: UIControlContentHorizontalAlignmentCenter,

        width: 34,
        height: 34,
        top: "100% - 80",
        left: "100% + 50"


  style :complete_register_button, extends: :big_button,
        title: 'REGISTER',


        width: 120,
        height: 34,
        top: "100% - 80",
        left: "100% + 84"

end