module MasseurDetailsHelper
  def hide_show_fake_age
    @masseur_detail.display_real_age ? false : true
  end
  
  def height_str(masseur_detail)
    if masseur_detail.height_feet && masseur_detail.height_inches
      "#{masseur_detail.height_feet}' #{masseur_detail.height_inches}\""
    else
      "Height N/A"
    end
  end
  
  def weight_str(masseur_detail)
    if masseur_detail.weight
      "#{masseur_detail.weight} #{masseur_detail.weight_unit}"
    else
      "Weight N/A"
    end
  end
end
