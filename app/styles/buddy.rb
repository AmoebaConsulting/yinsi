Teacup::Stylesheet.new :buddy do
  import :application

  style :root,
    backgroundColor: @white,
    clipsToBounds: true

  #
  # Buddy list styles:
  #
  style :buddy_cell,
    backgroundColor: @input_dark,
    selectionStyle: UITableViewCellSelectionStyleNone
    #separatorColor: UIColor.redColor,

  style :buddy_name,
    textColor: @green_light,
    font: :bold.uifont(17),
    width: 160,
    textAlignment: :right,
    #backgroundColor: @white,
    left: 0

  style :buddy_total_calls,
    textColor: :red.uicolor,
    text: "Whatever man you stink",
    left: 0, top: 0, width: 200,
    font: :bold.uifont(18)

  #
  # Add a buddy screen styles:
  #
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


