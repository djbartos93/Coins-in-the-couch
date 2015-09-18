class SettingsController < ApplicationController
  before_action :set_settings, only: [:edit, :update, :show]
  def index
    @settings = Setting.all
  end

  def new
    @settings = Setting.new
  end


  def update
    @settings.update(params)
  end

  private

     def params
        params.require(:key).permit(:value, :etc)
     end
     def set_settings
       @settings = Setting.find params[:key]
     end

end
