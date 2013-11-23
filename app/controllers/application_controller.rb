class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  helper_method :page, :per_page, :total_pages, :midpoint, :next_page, :prev_page, :url_for_page, :current_url

  def page
    params[:page].to_i || 1
  end

  def per_page
    50
  end

  def total_pages
    (count/per_page).floor
  end

  def midpoint
    (total_pages/2).floor
  end
  
  def next_page
    page == total_pages ? page : page + 1
  end

  def prev_page
    page == 1 ? 1 : page - 1
  end

  def current_url
    url_for :only_path=>false,:overwrite_params=>{}
  end

  def url_for_page page
    root = url_for(action: params[:action], controller: params[:controller])
    "#{root}?page=#{page}"
  end
end
