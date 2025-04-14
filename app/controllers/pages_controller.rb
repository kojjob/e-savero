class PagesController < ApplicationController
  # We can use fragment caching in the views if needed

  # Define custom layout if needed
  # layout 'pages'
  def index

  end

  def contact
    @page_title = "Contact Us"
  end

  def about
    @page_title = "About Us"
  end

  def terms
    @page_title = "Terms and Conditions"
  end

  def privacy
    @page_title = "Privacy Policy"
  end
  def show
    @page_title = params[:page].titleize
    render params[:page]
  end


end