class Admin::SiteSettingLogsController < Admin::BaseController
  skip_authorization_check

  def show
    @site_setting_log = SiteSettingLog.find(params[:id])
  end
end
