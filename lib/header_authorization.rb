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
      if !headers[:user_email].blank?
        self.current_user = User.find_by_email(headers[:user_email])
      end
    end
  end
  
  # Stub out header
  def stubbed_header_for_development
    headers[:user_email] = 'tester@test.com' if RAILS_ENV == 'development'
  end
end