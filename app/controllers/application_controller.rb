require "application_responder"

class ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  self.responder = CustomResponder
  respond_to :json
end
