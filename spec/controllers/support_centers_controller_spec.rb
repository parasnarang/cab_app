require 'spec_helper'

describe SupportCentersController do

  before :each do
    CASClient::Frameworks::Rails::Filter.fake("homer")
    @admin            = Admin.new
    @admin.name       = "homer"
    @admin.contact_no = "1234567890"
    @admin.status     = true
    @admin.save!
    @vendor            = Vendor.new
    @vendor.name       = "tina"
    @vendor.contact_no = "1234567890"
    @vendor.status     = true
    @vendor.save!
  end

  context "index" do
    it "should assign requested User data to @admin" do
      get :index
      response.should be_success
      assigns(:admin).should == @admin
    end

    it "should assign requested Vendor data to @vendor" do
      get :index
      response.should be_success
      assigns(:vendor).should == @vendor
    end

  end

  context "update" do
    it "should redirect to index path" do
      put :update, admin: @admin.name, vendor: @vendor.name
      response.should redirect_to('/support_centers')
    end

    it "should update status of required admin" do
      @admin1 = Admin.new
      @admin1.name = "riya "
      @admin1.contact_no = "1234567890"
      @admin1.status = false
      @admin1.save!
      put :update, admin: @admin1.name, vendor: @vendor.name
      Admin.where(name: @admin1.name).first.status.should == true
      Admin.where(name: @admin.name).first.status.should == false
    end

    it "should update status of required vendor" do
      @vendor1 = Vendor.new
      @vendor1.name = "riya "
      @vendor1.contact_no = "1234567890"
      @vendor1.status = false
      @vendor1.save!
      put :update, admin: @admin.name, vendor: @vendor1.name
      Vendor.where(name: @vendor1.name).first.status.should == true
      Vendor.where(name: @vendor.name).first.status.should == false
    end
  end

  context "edit" do
    it "should assign requested User data to @admins" do
      get :edit
      assigns(:admins).should == [@admin]
    end

    it "should assign requested Vendor data to @vendors" do
      get :edit
      assigns(:vendors).should == [@vendor]
    end
  end

  context "show" do
    before :each do
      @pick_up_date_time = Time.now + 1.days
      @cab_request  =  CabRequest.create!( requester: "homer", traveler_name: "self",pick_up_date: @pick_up_date_time.to_date,
                        pick_up_date_time: @pick_up_date_time, contact_no: "9039409828",
                        source: "Guest House", destination: "ThoughtWorks", no_of_passengers: 1, comments: "something" )
      @from = Time.now.to_date
      @to = (Time.now + 2.days).to_date
    end

    it "should assign CabRequest data to @cab_requests " do
      get :show, from: @from, to: @to
      assigns(:cab_requests).should == [@cab_request]
    end

    it "should render html page" do
      get :show,format: "html", from: @from, to: @to
      response.should render_template("support_centers/show")
    end

    it "should render xls page" do
      get :show,format: "xls", from: @from, to: @to
      response.should render_template("support_centers/show")
    end
  end
end