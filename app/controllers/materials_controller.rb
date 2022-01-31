class MaterialsController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]
  
  def index
    @materials = Material.all
  end

  def show; end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    if @material.save!
      redirect_to material_path(@material)
    else
      render :new
    end
  end

  def edit; end

  def update
    @material.update(material_params)
    redirect_to material_path(@material)
  end

  def destroy
    @material.destroy
    redirect_to materials_path
  end

  private

  def find
    @material = Material.find(params[:id])
  end

  def material_params
    params.require(:material).permit(:name, :category, :qty)
  end
end
