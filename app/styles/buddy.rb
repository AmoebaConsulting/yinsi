Teacup::Stylesheet.new :buddy do
  import :yinsi_application

  style :root,
    backgroundColor: @white

  style :table_cell,
    backgroundColor: @clouds,
    #separatorColor: UIColor.redColor,
    selectionStyle: UITableViewCellSelectionStyleNone

  style :table_cell_title,
    textColor: @blackish

  # Add a buddy screen styles:

  style :username, extends: :big_input,
        returnKeyType: :go,
        placeholder: "Enter Username"

  style :add_button, extends: :big_button,
        title: "Add",
        font: :bold.uifont(24)

end