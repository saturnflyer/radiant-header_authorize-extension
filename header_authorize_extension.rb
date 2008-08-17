require_dependency 'application'
HEADER_AUTHORIZE_KEY = 'authorization.header'
HEADER_AUTHORIZE_ATTR = 'authorization.attribute'
HEADER_AUTHORIZE_DEV_ACCOUNT = 'authorization.development.account'
HEADER_AUTHORIZE_USER_INIT = 'authorization.users.create'

class HeaderAuthorizeExtension < Radiant::Extension
  version "1.0"
  description "Alterations of the Login System to accept Header information for authorization."
  url "http://saturnflyer.com/"
  
  def activate
    ApplicationController.class_eval %{
      include HeaderAuthorization
    }
    if Radiant::Config[HEADER_AUTHORIZE_KEY].blank?
      Radiant::Config[HEADER_AUTHORIZE_KEY] = 'HTTP_USER_ID'
      auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_KEY)
      if auth_config.respond_to?(:description)
        auth_config.update_attribute :description, "This header will be used to authenticate users against this application's database. You'll need to restart for changes to take effect."
      end
    end
    if Radiant::Config[HEADER_AUTHORIZE_ATTR].blank?
      Radiant::Config[HEADER_AUTHORIZE_ATTR] = 'login'
      auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_ATTR)
      if auth_config.respond_to?(:description)
        auth_config.update_attribute :description, "This attribute on the user record will be used to authenticate against the HTTP header. You'll need to restart for changes to take effect."
      end
    end
    if RAILS_ENV == 'development'
      if Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT].blank?
        Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT] = User.find(:first)[:login]
        auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_DEV_ACCOUNT)
        if auth_config.respond_to?(:description)
          auth_config.update_attribute :description, "This value will be used in development to mock the user authorization against the HTTP header. Set an empty value to disable the mock authorization. You'll need to restart for changes to take effect."
        end
      end
    end
    
  end
  
end