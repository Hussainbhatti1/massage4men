class Admin::SubscriptionsController < Admin::BaseController
  before_action :authenticate_admin!
  load_and_authorize_resource
  
  def index
    # Calculate revenue
    @this_year_transactions = SubscriptionTransaction.where('success = ? AND created_at >= ?', true, Time.zone.now.beginning_of_year)
    
    @today_transactions = @this_year_transactions.where('created_at >= ?', Time.zone.now.beginning_of_day)
    @this_month_transactions = @this_year_transactions.where('created_at >= ?', Time.zone.now.beginning_of_month)
  end
end
