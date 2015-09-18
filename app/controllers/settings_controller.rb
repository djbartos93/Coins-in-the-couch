class SettingsController < ApplicationController
  before_action :set_settings, only: [:edit, :update, :show]
  def index
  @settings = Setting.all
  @setting = Setting.new
  end
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @settings = Setting.new
  end


  def update
    @settings.update_attributes(setting_params)
    redirect_to :action => 'index'
  end

  private

  def setting_params
    params.require(:setting).permit(:value, :key)
  end

     def set_settings
       @settings = Setting.find params[:id]
     end

end
