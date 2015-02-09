class Api::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def unprocessable_entity(record)
    render json: { error: record.errors.full_messages }, status: :unprocessable_entity
  end

  def unexpected_error
    render json: { error: 'Unexpected Error' }, status: :internal_server_error
  end

  private

  def record_not_found(error)
    render json: { error: error.message }, status: :not_found
  end
end
