require_dependency 'application'
HEADER_AUTHORIZE_KEY = 'authorization.header'
HEADER_AUTHORIZE_ATTR = 'authorization.attribute'
HEADER_AUTHORIZE_DEV_ACCOUNT = 'authorization.development.account'
HEADER_AUTHORIZE_USER_INIT = 'authorization.users.create'
HEADER_AUTHORIZE_ANONYMOUS_VAL = 'authorization.anonymous.value'
HEADER_AUTHORIZE_ANONYMOUS_REDIRECT = 'authorization.anonymous.redirect'

class HeaderAuthorizeExtension < Radiant::Extension
  version "1.0"
  description "Alterations of the Login System to accept Header information for authorization."
  url "http://saturnflyer.com/"
  
  def activate
    ApplicationController.class_eval %{
      include HeaderAuthorization
    }
    if ActiveRecord::Base.connection.tables.include?('config')
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
      if Radiant::Config[HEADER_AUTHORIZE_USER_INIT].blank?
        Radiant::Config[HEADER_AUTHORIZE_USER_INIT] = true
        auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_USER_INIT)
        if auth_config.respond_to?(:description)
          auth_config.update_attribute :description, "When this is set to true, any authorized use that enters will have a user account created for them. To disable this, set the value to 'false'"
        end
      end
      if Radiant::Config[HEADER_AUTHORIZE_ANONYMOUS_VAL].blank?
        Radiant::Config[HEADER_AUTHORIZE_ANONYMOUS_VAL] = 'anonymous'
        auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_ANONYMOUS_VAL)
        if auth_config.respond_to?(:description)
          auth_config.update_attribute :description, "A user with this given value for her authorization.header will be used to restricted from access."
        end
      end
      if Radiant::Config[HEADER_AUTHORIZE_ANONYMOUS_REDIRECT].blank?
        Radiant::Config[HEADER_AUTHORIZE_ANONYMOUS_REDIRECT] = '/'
        auth_config = Radiant::Config.find_by_key(HEADER_AUTHORIZE_ANONYMOUS_REDIRECT)
        if auth_config.respond_to?(:description)
          auth_config.update_attribute :description, "An anonymous user will be redirected to the location given here."
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
  
end