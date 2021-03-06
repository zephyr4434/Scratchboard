require 'spec_helper'

describe ProjectsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
      @project = Factory(:project)
    
    it "should show the projects thoughts" do
      thought1 = Factory(:thought, :project => @project, :content => "Foo bar")
      thought2 = Factory(:thought, :project => @project, :content => "Baz quux")
      get :show, :id => @project
      response.should have_selector("div.content", :content => thought1.content)
      response.should have_selector("div.content", :content => thought2.content)
    end
    end
    
  end
  
  describe "POST 'create'" do
    
    before(:each) do 
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
      
      before(:each) do 
        @attr = { :body => "" }
      end
      
      it "should not create a project" do
        lambda do
          post :create, :project => @attr
        end.should_not change(Project, :count)
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :body => "Body text" }
      end
      
      it "should create a project" do
        lambda do
          post :create, :project => @attr 
        end.should change(Project, :count).by(1)
      end
      
      it "should have a flash message" do 
        post :create, :project => @attr
        flash[:success].should =~ /project created/i
      end
    end
  end
end