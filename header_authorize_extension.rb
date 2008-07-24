require_dependency 'application'

class HeaderAuthorizeExtension < Radiant::Extension
  version "1.0"
  description "Alterations of the Login System to accept Header information for authorization."
  url "http://saturnflyer.com/"
  
  def activate
    ApplicationController.class_eval %{
      include HeaderAuthorization
    }
  end
  
end