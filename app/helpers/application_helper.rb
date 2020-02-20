module ApplicationHelper
  include Carmen

  def generate_html_tag
    data_attrs = {}

    # Return an <html> tag with data attributes, if specified
    if @tracking_link && @tracking_link.should_pop_signup?
      data_attrs[:pop_signup] = true
    end

    if @pic_required
      data_attrs[:pic_required] = true
    end

    if @pic_upload_url
      data_attrs[:pic_upload_url] = @pic_upload_url
    end

    if data_attrs
      attr_str = data_attrs.map{|k,v| "data-#{k.to_s.gsub('_', '-')}=\"#{v}\""}.join(' ')
    end

    raw("<html#{attr_str ? ' ' + attr_str : ''}>")
  end

  def edit_path_for(user)
    # TODO: Make this less brittle.
    if user.kind_of? Client
      '/clients'
    elsif user.kind_of? Masseur
      '/masseurs'
    end
  end
  
  def dashboard_path(user)
    if user.kind_of? Client
      dashboard_client_path(user)
    elsif user.kind_of? Masseur
      dashboard_masseur_path(user)
    else
      'What are you doing?!'
    end
  end
  
  def icon_link_to(anchor, path, icon)
    link_to path, class: 'btn btn-lg btn-default' do
      raw("<i class=\"fa #{icon}\"></i> #{anchor}")
    end
  end
  
  def avatar_or_icon(user)
    # Show the user's avatar as a circle if they have one; otherwise a fontawesome generic user
    if user.profile_photo.present?
      image_tag user.profile_photo.url(:thumb), class: 'img-responsive img-circle header-nav-profile-photo'
    else
      raw('<i class="fa fa-user"></i>')
    end
  end
  
  def clean_time_ago_in_words(time)
    time_ago_in_words(time).gsub(/(less than|about|almost|over)\s/, '')
  end
  
  def yes_or_no(bool)
    bool ? 'Yes' : 'No'
  end

  def us_states
    [
      ['Alabama', 'AL'],
      ['Alaska', 'AK'],
      ['Arizona', 'AZ'],
      ['Arkansas', 'AR'],
      ['California', 'CA'],
      ['Colorado', 'CO'],
      ['Connecticut', 'CT'],
      ['Delaware', 'DE'],
      ['District of Columbia', 'DC'],
      ['Florida', 'FL'],
      ['Georgia', 'GA'],
      ['Hawaii', 'HI'],
      ['Idaho', 'ID'],
      ['Illinois', 'IL'],
      ['Indiana', 'IN'],
      ['Iowa', 'IA'],
      ['Kansas', 'KS'],
      ['Kentucky', 'KY'],
      ['Louisiana', 'LA'],
      ['Maine', 'ME'],
      ['Maryland', 'MD'],
      ['Massachusetts', 'MA'],
      ['Michigan', 'MI'],
      ['Minnesota', 'MN'],
      ['Mississippi', 'MS'],
      ['Missouri', 'MO'],
      ['Montana', 'MT'],
      ['Nebraska', 'NE'],
      ['Nevada', 'NV'],
      ['New Hampshire', 'NH'],
      ['New Jersey', 'NJ'],
      ['New Mexico', 'NM'],
      ['New York', 'NY'],
      ['North Carolina', 'NC'],
      ['North Dakota', 'ND'],
      ['Ohio', 'OH'],
      ['Oklahoma', 'OK'],
      ['Oregon', 'OR'],
      ['Pennsylvania', 'PA'],
      ['Puerto Rico', 'PR'],
      ['Rhode Island', 'RI'],
      ['South Carolina', 'SC'],
      ['South Dakota', 'SD'],
      ['Tennessee', 'TN'],
      ['Texas', 'TX'],
      ['Utah', 'UT'],
      ['Vermont', 'VT'],
      ['Virginia', 'VA'],
      ['Washington', 'WA'],
      ['West Virginia', 'WV'],
      ['Wisconsin', 'WI'],
      ['Wyoming', 'WY']
    ]    
  end
  
  def mx_states
    [
      ["Aguascalientes", "AGU"],
      ["Baja California", "BCN"],
      ["Baja California Sur", "BCS"],
      ["Campeche", "CAM"],
      ["Chihuahua", "CHH"],
      ["Chiapas", "CHP"],
      ["Coahuila", "COA"],
      ["Colima", "COL"],
      ["Distrito Federal", "DIF"],
      ["Durango", "DUR"],
      ["Guerrero", "GRO"],
      ["Guanajuato", "GUA"],
      ["Hidalgo", "HID"],
      ["Jalisco", "JAL"],
      ["México", "MEX"],
      ["Michoacán", "MIC"],
      ["Morelos", "MOR"],
      ["Nayarit", "NAY"],
      ["Nuevo León", "NLE"],
      ["Oaxaca", "OAX"],
      ["Puebla", "PUE"],
      ["Querétaro", "QUE"],
      ["Quintana Roo", "ROO"],
      ["Sinaloa", "SIN"],
      ["San Luis Potosí", "SLP"],
      ["Sonora", "SON"],
      ["Tabasco", "TAB"],
      ["Tamaulipas", "TAM"],
      ["Tlaxcala", "TLA"],
      ["Veracruz", "VER"],
      ["Yucatán", "YUC"],
      ["Zacatecas", "ZAC"]
    ]
  end
  
  def abbreviation_for_state(state)
    STRUCTURED_STATES.each do |s|
      if s[:name].downcase.eql?(state.downcase)
        return s[:abbr]
      end
    end
  end
  
  def states_for_country(country)
    Country.coded(country).subregions.collect { |s| [s.name, s.code] }
  end

  def phone_mask_for_country(country)
    phone_info = PHONE_FORMATS.select { |format| format[:country] == country }.first
    
    if phone_info
      phone_info[:phone_format]
    else
      '999999999999999'
    end
  end
  
  def use_postal_code?(country)
    phone_info = PHONE_FORMATS.select { |format| format[:country] == country }.first
    
    if phone_info
      phone_info[:use_postal_code]
    else
      true
    end    
  end
  
  def ip_info(ip, as_string = true)
    return 'localhost' if ip == '127.0.0.1'
    
    ip_info = JSON.parse(open("http://ipinfo.io/#{ip}").read)

    if as_string
      "#{ip_info['city']}, #{ip_info['region']} #{ip_info['country']}"
    else
      ip_info
    end
  end
  
  # SFW mode
  def logo_or_sfw
    SFW_MODE ? 'https://placehold.it/488x185' : 'logo-full.png'
  end

  
  def options_for_combined_email
    masseur_email = Masseur.order(id: :desc).map{|x| [x.email,x.id]}
    # client_email =Client.all.map{|y|[y.email ,y.id]}
    # masseur_email.concat(client_email)
    options_for_select(masseur_email)
  end
end
