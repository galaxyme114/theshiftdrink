class Admin::MaterialsController < Admin::BaseController
  load_and_authorize_resource :class => Issue

  before_action :set_material, only: [:edit, :update, :destroy]

  # GET /admin/materials
  def index
  	@materials = Issue.materials.order(:created_at)
  end

 # GET /admin/materials/new
  def new
  	@material = Issue.new
  end

  # POST /admin/materials
  def create
    @material = Issue.new material_params.merge(creator: current_user)

    if @material.save
      redirect_to materials_path, notice: 'Material was successfully created'
    else
      flash.now[:danger] = @material.first_error_message
      render :new
    end
  end

  # GET /materials/:id/edit
  def edit
  end

  # PATCH /materials/:id
  def update
    if @material.update(material_params)
      redirect_to edit_material_path(@material), notice: 'Material was successfully updated'
    else
      flash.now[:danger] = @material.first_error_message
      render :edit
    end
  end

  # DELETE /materials/:id
  def destroy
  end

  protected
    def material_params
      params.require(:issue).permit(:number, :alias_name, :title, :published_on).merge(role: 'Material')
    end
end
