class ArbitraryBooleanInput < SimpleForm::Inputs::BooleanInput
  def input(wrapper_options = nil)
    tag_name = "#{@builder.object_name}[#{attribute_name}]"
    template.check_box_tag(tag_name, options['value'] || 1, options['checked'], options)
  end
end