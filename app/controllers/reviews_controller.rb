class ReviewsController < ApplicationController
  load_and_authorize_resource :masseur
  load_and_authorize_resource :review, through: :masseur, except: [:approve, :deny]
  
  # cancancan detects approve/deny as collection resources. Tell it they're not.
  load_and_authorize_resource :review, through: :masseur, id_param: :review_id, only: [:approve, :deny]
  
  def new
    render layout: false
  end
  
  def show
    render layout: false
  end

  def create
    @review = @masseur.reviews.build(review_params)
    @review.client = current_client
    
    if @review.save
      ret = {
        success: true,
        msg: 'Thank you for your review!'
      }      
    else
      ret = {
        success: false,
        error: 'Your review could not be submitted.'
      }
    end
        
    render json: ret
  end
  
  def approve
    if @review.update_attributes(masseur_approved: true)
      flash[:success] = 'You have approved this review. It is now visible on your ads.'
    else
      flash[:error] = 'Something went wrong and the review could not be approved. Please try again.'
    end
    
    redirect_to dashboard_masseur_path(current_masseur)
  end
  
  def deny
    if @review.update_attributes(masseur_approved: false)
      # Inform the staff so they can override if necessary
      AdminMailer.notify_admin_of_rejected_review(@review).deliver_now

      flash[:success] = 'You have rejected this review. It will not appear on your ads.'
    else
      flash[:error] = 'Something went wrong and the review could not be rejected. Please try again.'
    end
    
    redirect_to dashboard_masseur_path(current_masseur)
  end
  
  private
  def review_params
    params.require(:review).permit(
                                    :review,
                                    :rating,
                                    :times_seen,
                                    :appointment_date,
                                    :appointment_location,
                                    :appointment_scheduled_length,
                                    :appointment_actual_length,
                                    :masseur_on_time,
                                    :masseur_notified_of_lateness,
                                    :incall_or_outcall,
                                    :service_as_requested,
                                    :masseur_appearance,
                                    :masseur_personality,
                                    :likelihood_to_rebook,
                                    :likelihood_to_refer
                                   )
  end
end
