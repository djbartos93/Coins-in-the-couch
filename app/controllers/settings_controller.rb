class SettingsController < ApplicationController
  def edit
      @setting = Setting.find(params[:key])
    end

end
