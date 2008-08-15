module HeaderAuthorization
  def self.append_features(base)
    base.class_eval %{
      before_filter :stubbed_header_for_development
      before_filter :authenticate_with_header
    }
    super
  end
  
  protected
  
  def authenticate_with_header
    unless self.current_user
      if !request.env[auth_header].blank?
        self.current_user = User.send("find_by_#{auth_attr}",request.env[auth_header])
      end
    end
  end
  
  def auth_header
    Radiant::Config[HEADER_AUTHORIZE_KEY] || 'HTTP_USER_ID'
  end
  
  def auth_attr
    Radiant::Config[HEADER_AUTHORIZE_ATTR] || 'login'
  end
  
  # Stub out header
  def stubbed_header_for_development
    if RAILS_ENV == 'development' && !Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT].blank?
      request.env[auth_header] = Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT]
    end
  end
end