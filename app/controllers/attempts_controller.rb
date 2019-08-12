class AttemptsController < ApplicationController
  def create
    Rails.logger.info "CREATE INSIDE ATTEMPTS CONTROLLER"
    Rails.logger.info params[:id]
    Rails.logger.info params
    Rails.logger.info params[:quiz_id]
    
    Rails.logger.info "No redirect, not a problem for now"
  end
end