require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe HatsController do
  describe "when logged in" do
    before do
      @user = User.make
      @sprint = @user.sprints.make
      login! @user
    end

    describe "creating a hat" do
	    it "should work for black" do
	      lambda {
	        post :create, :sprint_id => @sprint.id, :type => "black", :value => "moo"
	      }.should change(BlackHat, :count)
	      response.should be_success
	    end
	
	    it "should work for yellow" do
	      lambda {
	        post :create, :sprint_id => @sprint.id, :type => "yellow", :value => "holla"
	      }.should change(YellowHat, :count)
	      response.should be_success
	    end
	
	    it "should error if you give a bad hat color" do
	      post :create, :sprint_id => @sprint.id, :type => "yourmom"
	      response.should_not be_success
	    end
    end

    describe "updating a hat" do
      before do
        @black = @sprint.black_hats.make
        @yellow = @sprint.yellow_hats.make
        @green = GreenHat.make(:black_hat => @black)
      end

      it "should work for black" do
        post :update, :id => @black.id, :sprint_id => @sprint.id, :value => "mooo", :type => "black"
        @black.reload.text.should == "mooo"
        response.should be_success
      end

      it "should work for yellow" do
        post :update, :id => @yellow.id, :sprint_id => @sprint.id, :value => "mooo", :type => "yellow"
        @yellow.reload.text.should == "mooo"
        response.should be_success
      end

      it "should work for green" do
        post :update, :id => "text_" + @green.id.to_s, :sprint_id => @sprint.id, :value => "mooo", :type => "green"
        @green.reload.text.should == "mooo"
        response.should be_success
      end

      it "should be able to update green owner" do
        post :update, :id => "owner_" + @green.id.to_s, :sprint_id => @sprint.id, :value => "Bob Sagat", :type => "green"
        @green.reload.owner.should == "Bob Sagat"
        response.should be_success
      end

      it "should give an error for purple" do
        post :update, :id => "owner_" + @green.id.to_s, :sprint_id => @sprint.id, :value => "Bob Sagat", :type => "purple"
        response.should_not be_success
      end

      it "should require a valid sprint for this user" do
        post :update, :id => @yellow.id, :sprint_id => Sprint.make.id
        response.should_not be_success
      end
    end
  end
end
