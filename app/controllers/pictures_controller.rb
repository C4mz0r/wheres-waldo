class PicturesController < ApplicationController
    
  def show
    #byebug
    @picture = Picture.find(params[:id])
    session[:current_picture_id] = params[:id]
  end
  
  def new
    @picture = Picture.new
  end
  
  def create
    #byebug    
    @picture = Picture.BuildPicture(current_user, picture_params[:title])
    if (@picture.save)
      #byebug
      redirect_to @picture
    else
      render 'new'
    end
  end
  
  def tagCharacter
    #byebug
    @currentPicture = session[:current_picture_id]
    @picture = Picture.find(@currentPicture);
    @person = @picture.characters.find_by_name(params[:name])
    x = params[:xPosition]
    y = params[:yPosition]
    result = false
    if @person.wasClicked(x, y)
      # set database to true
      @person.update_attribute(:isFound, true)
      result = true      
    end
    
    # send the response back to the AJAX call
    respond_to do |format|      
      format.json { render :json => result, :status => 200 }
    end
  end
  
  def charactersToFind
    #byebug
    @currentPicture = session[:current_picture_id]
    @picture = Picture.find(@currentPicture);
    @people = @picture.characters.where(:isFound => false)
    respond_to do |format|
      format.json { render :json => @people.map{ |p| p.name }, :status => 200 }
    end
  end
  
  
  
  private
    def picture_params
      params.require(:picture).permit(:title)
    end
    
    
    
    #def set_current_picture_id(value)
    #  @currentPictureId = value
    #end
    
    #def get_current_picture_id
    #  @currentPictureId
    #end
  
end
