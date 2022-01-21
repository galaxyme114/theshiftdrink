class MaterialsController < ApplicationController
  before_action :set_material_issue, only: [:show]
  before_action :set_page

  layout 'client'

  def show
  end

  protected
    def set_material_issue
      @issue = Issue.materials.find_by(friendly_id: params[:material_id].to_s)
    end

    def set_page
      @page = @issue.pages.where(friendly_id: params[:id]).take
    end
end