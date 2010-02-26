class PrefsController < ApplicationController


  def index
    @prefs = Pref.first
    if @prefs.blank?
      @prefs = Pref.new(:name => 'Current Sprint')
      @prefs.save!
    end
  end

end
