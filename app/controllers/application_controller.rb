class ApplicationController < ActionController::Base
  protect_from_forgery

  def return_json_status(code, msg)
    render :json => { :status => code, :reason => msg }, :status => code
  end
end
