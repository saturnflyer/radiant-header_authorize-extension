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
      if !headers[auth_config].blank?
        self.current_user = User.find_by_email(headers[auth_config])
      end
    end
  end
  
  def auth_config
    Radiant::Config[HEADER_AUTHORIZE_KEY].downcase.to_sym || :user_email
  end
  
  # Stub out header
  def stubbed_header_for_development
    headers[auth_config] = 'tester@test.com' if RAILS_ENV == 'development'
  end
end