class TemplatesController < ApplicationController
  def show
    # @category = Category.find(params[:category_id])
    @template = Template.find(params[:id])
  end

  def new
    @categories = Category.all
    @template = Template.new
    render :new
  end

  def create
    @category = Category.find(params[:category_id])
    @template = @category.templates.new(template_params)
    if @template.save
      flash[:notice] = "Template successfully added!"
      redirect_to template_path(@template)
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
    @template = Template.find(params[:id])
    @category = @template.category
  end

  def update
    @template = Template.find(params[:id])
    if @template.update(template_params)
      flash[:notice] = "Template successfully updated!"
      redirect_to template_path(@template)
    else
      render :edit
    end
  end

  def destroy
    template = Template.find(params[:id])
    if template.delete
      flash[:notice] = template.title.capitalize + " Template Deleted"
      redirect_to admin_path
    else
      flash[:alert] = "Template Delete Failed"
    end
  end

private
  def template_params
    params.require(:template).permit(:title, :description, :category_id)
  end
end
