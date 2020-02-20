module ConversationsHelper
  def conversation_avatar_for(user, size = :small_thumb)
    return image_path("missing-#{size.to_s}.png") if user.nil?

    if user.kind_of? Client
      user.profile_picture.url(size)
    elsif user.kind_of? Masseur
      user.profile_photo.url(size)
    end
  end

  def display_name_for(user)
    case user
    when current_user
      'You'
    when nil
      '(deleted)'
    else
      user.screen_name
    end
  end
end
