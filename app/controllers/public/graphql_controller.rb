class Public::GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[execute]
  before_action :doorkeeper_authorize!

  def schema
    PublicSchema
  end

  def context
    { doorkeeper_app: doorkeeper_token.application }
  end

  def variables
    ensure_hash(params[:variables])
  end

  def execute
    result = params[:_json] ? multiplex_execution(params) : single_execution(params)
    render json: result
  rescue => e
    raise e unless Rails.env.development?
    handle_error_in_development e
  end

  protected

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def single_execution(params)
    schema.execute(params[:query], variables: variables, context: context, operation_name: params[:operationName])
  end

  def multiplex_execution(params)
    queries = params[:_json].map do |param|
      {
        query: param[:query],
        operation_name: param[:operationName],
        variables: variables,
        context: context,
      }
    end

    schema.multiplex(queries)
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { error: { message: e.message, backtrace: e.backtrace }, data: {} }, status: 500
  end
end
