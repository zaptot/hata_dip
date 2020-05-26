class ApplicationController < ActionController::Base
  layout 'application', except: [:sign_in]
end
