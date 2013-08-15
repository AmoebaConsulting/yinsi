Teacup::Stylesheet.new :buddy do
  import :yinsi_application

  style :root,
    backgroundColor: @clouds

  style :username, extends: :big_input,
        returnKeyType: :go,
        placeholder: "Enter Username"

  style :add_button, extends: :big_button,
        title: "Add",
        font: :bold.uifont(24)

end