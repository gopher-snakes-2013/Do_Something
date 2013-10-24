module FacebookHelpers
  def current_fb_id(email)
    User.find_by_email(email).id
  end

  def current_fb_user(email)
    User.find_by_email(email)
  end

  def email_in_database?(email)
    true if User.find_by_email(email)
  end

  def fb_id_in_database?(fb_id)
    true if User.find_by_email(fb_id)
  end

  def fb_user_in_database?(email, fb_id)
    email_in_database?(email) && fb_id_in_database?(fb_id)
  end
end
