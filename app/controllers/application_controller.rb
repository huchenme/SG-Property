class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper
  protect_from_forgery
end
