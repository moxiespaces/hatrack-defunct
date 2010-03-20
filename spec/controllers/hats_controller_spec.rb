require File.join(File.dirname(__FILE__), "..", "spec_helper")

describe HatsController do
  describe "logged in" do
    before do
      @user = User.make
      login! @user
    end

    it "should be able to create a green hat"
    it "should be able to create a black hat"
    it "should be able to create a yellow hat" do
      sprint = @user.sprints.make
      yellow = YellowHat.make_unsaved
      YellowHat.should_receive(:new).and_return(yellow)
      yellow.should_receive(:save!)
      post :create, :sprint_id => sprint.id, :type => "yellow", :value => "holla"
      response.should be_success
    end

    it "should error if you give a bad hat color"
  end
end
