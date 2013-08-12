Teacup::Stylesheet.new :registration do
  import :yinsi_application

  v_padding = 10

  #style UIView,
  #  gradient: { colors: [@green, @green_medium] }

  style :root,
        backgroundColor: @green_medium

  style :table,
        #height: 60,
        #backgroundColor: @green,
        #backgroundView: {},
        font: UIFont.boldSystemFontOfSize(100)
        #backgroundView: {
        #  backgroundColor: @green_medium
        #}

  #style :table_cell,
  #      textLabel: {
  #        textColor: @green
  #      },
  #      #imageView: { gradient: {colors: [@green, @green_medium]}}



  #style UIButton,
  #  backgroundColor: @green_medium
end