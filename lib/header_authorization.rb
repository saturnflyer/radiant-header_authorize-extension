module HeaderAuthorization
  def self.append_features(base)
    base.class_eval %{
      before_filter :stub_header_for_development
      before_filter :authenticate_with_header
    }
    super
  end
  
  def auth_header
    Radiant::Config[HEADER_AUTHORIZE_KEY] || 'HTTP_USER_ID'
  end
  
  def auth_attr
    Radiant::Config[HEADER_AUTHORIZE_ATTR] || 'login'
  end
  
  def authenticate_with_header
    unless self.current_user
      if !request.env[auth_header].blank?
        if self.current_user = User.send("find_by_#{auth_attr}",request.env[auth_header])
          self.send(:set_current_user)
        else
          if Radiant::Config[HEADER_AUTHORIZE_USER_INIT]
            self.current_user = User.create!(:login => request.env[auth_header], :name => request.env[auth_header], :password => request.env[auth_header], :password_confirmation => request.env[auth_header])
            self.send(:set_current_user)
            flash[:notice] = 'Welcome. A new account has been created for you.'
          end
        end
      end
    end
  end
  
  # Stub out header
  def stub_header_for_development
    if RAILS_ENV.match(/development|local/) && !Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT].blank?
      request.env[auth_header] = Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT]
    end
  end
end