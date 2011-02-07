class ImagesController < ApplicationController
  def index
    @images = Image.order("created_at DESC")
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = "Successfully created image."
      redirect_to :action => "index"
    else
      render :action => 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      flash[:notice] = "Successfully updated image."
      redirect_to @image
    else
      render :action => 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:notice] = "Successfully destroyed image."
    redirect_to images_url
  end

  def next
    @image = Image.current_image
    if(!@image.nil? && @image.display_at > Time.now - 1.days)
      render :text => @image.url
    else
      render :text => Image.random.url
    end
  end
end
