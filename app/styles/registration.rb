Teacup::Stylesheet.new :registration do
  import :application

  style :root,
    background_gradient: {
        top: :black.uicolor,
        bottom: "#403942".uicolor
    }

end