Teacup::Stylesheet.new :buddy do
  import :application

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
        placeholder: "ENTER USERNAME",

        width: 260,
        height: 38,
        top: 124,
        left: 0

  style :add_button, extends: :big_button,
        title: "ADD",
        textColor: @purple_light,

        height: 34,
        width: 120,
        top: 304,
        #top: 184,
        left: 140



end