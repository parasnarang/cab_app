require 'spec_helper'

describe AdminsController do
  before :each do
    CASClient::Frameworks::Rails::Filter.fake("homer")
    @sample_admin = Admin.create(name: 'pulkitko', contact_no: "8765432100", status: true)
    @sample_admin2 = Admin.create(name: 'ppathak', contact_no: "8765432100", status: false)
    @sample_admins = [@sample_admin,@sample_admin2]
  end
  context 'index' do
    it 'should get list of admins' do
      get :index
      puts controller.instance_variable_get(:@admins).should == @sample_admins
    end
  end
end