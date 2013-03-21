require 'spec_helper'

describe ApplicationController do
  # This is the anonymous controller:
  controller do
    def new
      render :text => 'Hello'
    end
  end

  it 'should redirect to CAS login page if user is not logged in' do
    get :new
    if !session[:cas_sent_to_gateway].nil?
      response.should redirect_to('https://cas.thoughtworks.com/cas/login?service=http%3A%2F%2Ftest.host%2Fanonymous%2Fnew')
    end
  end

  it 'should redirect to new request page if user is logged in' do
    CASClient::Frameworks::Rails::Filter.fake('homer')
    get :new
    response.should be_success
  end

end

