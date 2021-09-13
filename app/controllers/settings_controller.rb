class SettingsController < ApplicationController
  def show
  end

  def import
    DailyStatsDataImporter.import(params[:file].path, current_user.id)
    redirect_to "/app/stats", notice: "Upload complete"
  end
end
