class MaterialsController < ApplicationController
  before_action :find, only: [:show]
  def index
    @materials = Material.all
  end

  def show
  end

  private
  
  def find
    @material = Material.find(params[:id])
  end
end
