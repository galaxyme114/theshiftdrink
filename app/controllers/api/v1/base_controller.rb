class Api::V1::BaseController < ApplicationController
  protect_from_forgery :if => Proc.new { |c| c.request.format == 'application/json' }

  protected
    def default_serializer_options
      { root: false }
    end
end
