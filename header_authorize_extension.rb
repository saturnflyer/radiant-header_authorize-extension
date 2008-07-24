require_dependency 'application'
HEADER_AUTHORIZE_KEY = 'authorization.header'

class HeaderAuthorizeExtension < Radiant::Extension
  version "1.0"
  description "Alterations of the Login System to accept Header information for authorization."
  url "http://saturnflyer.com/"
  
  def activate
    ApplicationController.class_eval %{
      include HeaderAuthorization
    }
    if Radiant::Config[HEADER_AUTHORIZE_KEY].blank?
      Radiant::Config[HEADER_AUTHORIZE_KEY] = 'USER_EMAIL'
      auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_KEY)
      if auth_config.respond_to?(:description)
        auth_config.update_attribute :description, "This header will be user to authenticate users against this application's database. You'll need to restart for changes to take effect."
      end
    end
  end
  
end