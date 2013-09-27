Teacup::Stylesheet.new :buddy do
  import :application

  style :root,
    backgroundColor: @white,
    clipsToBounds: true


  style :table_cell,
    backgroundColor: @clouds,
    #separatorColor: UIColor.redColor,
    selectionStyle: UITableViewCellSelectionStyleNone

  style :table_cell_title,
    textColor: @green_light,
    font: :bold.uifont(17),
    width: 160,
    textAlignment: :right,
    backgroundColor: @white,
    left: 0




  style :buddy_cell,
        backgroundColor: @input_dark,

        height: 40,
        width: 260,
        left: 0


  # Add a buddy screen styles:

  style :username, extends: :big_input,
        returnKeyType: :go,
        placeholder: "ENTER USERNAME",

        width: 260,
        height: 38,
        top: 124,
        left: -260

  style :add_button, extends: :big_button,
        title: "ADD",
        textColor: @purple_light,
        setAlpha: 0.0,

        height: 34,
        width: 120,
        top: 304,
        #top: 184,
        left: 140



end


