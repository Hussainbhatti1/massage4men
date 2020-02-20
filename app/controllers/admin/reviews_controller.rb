class Admin::ReviewsController < Admin::BaseController
  load_and_authorize_resource :review

  def index
    @reviews = @reviews.order(created_at: :desc).page(params[:page])
  end
  
  def show
    render layout: false
  end
  
  def edit
    render layout: false    
  end
  
  def update
    if @review.update_attributes(review_params)
      flash[:notice] = 'Review updated.'
    else
      flash[:error] = 'Review could not be updated.'
    end
    
    redirect_to admin_reviews_path
  end
  
  def approve
    if @review.update_attributes(admin_approved: true)
      flash[:success] = 'Override successful. This review is now visible.'
    else
      flash[:error] = 'Something went wrong and the review could not be approved.'
    end
    
    redirect_to admin_reviews_path
  end
  
  def reject
    # If the review is rejected, then delete it
    if @review.destroy
      flash[:success] = 'Review deleted.'
    else
      flash[:error] = 'Review could not be deleted.'
    end
    
    redirect_to admin_root_path
  end
  
  def destroy
    if @review.destroy
      flash[:notice] = 'Review successfully deleted.'
    else
      flash[:error] = 'Review could not be deleted.'
    end

    redirect_to :back
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
