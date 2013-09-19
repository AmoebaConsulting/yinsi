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
        font: :bold.uifont(24),
        textColor: @green_logo,
        textAlignment: :center,
        backgroundColor: :clear,

        width: '100% - 40',
        height: 40,
        top: 20,
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
        top: 80,
        left: 20

  style :user_input, extends: :big_input,
        placeholder: "YOUR CHOICE",
        returnKeyType: :next,
        font: :normal.uifont(17),

        width: 260,
        height: 38,
        top: 120,
        left: 0


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
        top: 160,
        left: 20

  style :password_input, extends: :big_input,
        placeholder: "REQUIRED",
        returnKeyType: :next,
        font: :normal.uifont(17),
        secure: true,

        width: 260,
        height: 38,
        top: 200,
        left: 0

  style :confirm_label,
        text: 'CONFIRM:',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.6),
        textAlignment: :left,
        backgroundColor: :clear,

        width: 260,
        height: 38,
        top: 240,
        left: 20

  style :confirm_input, extends: :big_input,
        placeholder: 'RE-ENTER PASSWORD',
        returnKeyType: :next,
        font: :normal.uifont(17),
        secure: true,

        width: 260,
        height: 38,
        top: 280,
        left: 0


  style :break_line,
        text: '- - - - - - - - - - - - - - - - - - - - - - - - - -',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.4),
        textAlignment: :center,
        backgroundColor: :clear,

        width: '100% - 40',
        height: 20,
        top: 320,
        left: 20


  style :email_label,
        text: 'EMAIL:',
        numberOfLines: 1,
        font: :normal.uifont(17),
        textColor: @white.colorWithAlphaComponent(0.6),
        textAlignment: :left,
        backgroundColor: :clear,

        width: 260,
        height: 38,
        top: 340,
        left: 20

  style :email_input, extends: :big_input,
        placeholder: 'OPTIONAL',
        returnKeyType: :go,
        font: :normal.uifont(17),

        width: 260,
        height: 38,
        top: 380,
        left: 0






end