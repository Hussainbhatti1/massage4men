class Admin::SiteSettingsController < Admin::BaseController
  load_and_authorize_resource
  
  def index
    @site_setting = SiteSetting.first
  end

  def update
    if @site_setting.update_attributes(site_setting_params)
      if current_admin.present? && @site_setting.previous_changes.present?
        @site_setting_log = SiteSettingLog.create!(site_changes: @site_setting.previous_changes)
        AdminsSiteSettingLog.create!(admin_id: current_admin.id, site_setting_log_id: @site_setting_log.id)
      end
      redirect_to admin_site_settings_path, notice: 'Settings saved.'
    else
      render :index
    end
  end
  
  private
  def site_setting_params
    params.require(:site_setting).permit(
      :basic_package_price,
      :premium_package_price,
      :advertise_page,
      :privacy_page,
      :tos_page,
      :approval_required_for_new_masseurs,
      :payment_address,
      :admin_notification_email,
      :keywords,
      :badge_disclaimer
    )
  end
end
