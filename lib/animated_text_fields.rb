module AnimatedTextFields
  def animate_text_field(text_field)
    @animated_text_fields ||= []
    @animated_text_fields << text_field
    text_field.on(:editing_did_begin) do
      _animate_text_field(text_field, true)
    end

    text_field.on(:editing_did_end) do
      _animate_text_field(text_field, false)
    end

  end

  def dealloc
    if @animated_text_fields
      @animated_text_fields.each do |text_field|
        text_field.off(:all)
      end
    end
    super.dealloc
  end

  private

  def _animate_text_field(field, up)
    move_up_value = field.frame.origin.y + field.frame.size.height
    orientation = UIApplication.sharedApplication.statusBarOrientation

    if orientation == :portrait.uiorientation || :upside_down.uiorientation
      animated_distance = 216 - (460 - move_up_value-5)
    else
      animated_distance = 162 - (320 - move_up_value-5)
    end

    if animated_distance > 0
      movement = (up ? -animated_distance : animated_distance)
      self.view.delta_to([0,movement], duration: 0.3)
    end
  end
end