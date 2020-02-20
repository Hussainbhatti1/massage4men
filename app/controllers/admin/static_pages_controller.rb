class Admin::StaticPagesController < Admin::BaseController
  # load_and_authorize_resource
  skip_authorization_check

  def index
    @static_pages = StaticPage.all
  end

  def edit
    @static_page = StaticPage.friendly.find params[:id]
  end

  def create
    unless @static_page
        @static_page = StaticPage.friendly.find params[:id]
    end
    if @static_page.update_attributes(static_page_params)
      redirect_to admin_static_pages_path, notice: "Page '#{@static_page.title}' created!"
    else
      render :new
    end
  end

  def update
    unless @static_page
        @static_page = StaticPage.friendly.find params[:id]
    end
    if @static_page.update_attributes(static_page_params)
      redirect_to admin_static_pages_path, notice: "Page '#{@static_page.title}' updated!"
    else
      render :edit
    end
  end

  def destroy
    unless @static_page
        @static_page = StaticPage.friendly.find params[:id]
    end
    @static_page.destroy
    redirect_to "/admin/static_pages"
  end

  private
  def static_page_params
    params.require(:static_page).permit(*StaticPage.globalize_attribute_names)
  end
end
