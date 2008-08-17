require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationController, "with header authorization" do
  scenario :users
  
  before(:each) do
    Radiant::Config['authorization.header'] == 'HTTP_USER_ID'
    Radiant::Config['authorization.attribute'] == 'login'
    @controller = ApplicationController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @request.env['HTTP_USER_ID'] == 'Admin'
    get '/admin'
  end
  
  it "should get the header for authorization from Radiant::Config['authorization.header']" do
    @controller.auth_header.should == 'HTTP_USER_ID'
  end
  it "should get the user attribute for authorization from Radiant::Config['authorization.attribute']" do
    @controller.auth_attr.should == 'login'
  end
  it "should set the current user by comparing authorization.header and authorization.attribute from the users"
  describe "with Radiant::Config['authorization.users.create'] set to true" do
    it "should create a new user if the user with the authorization.header is not found"
  end
end