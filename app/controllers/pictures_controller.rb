class PicturesController < ApplicationController
    
  def show
    @picture = Picture.find(params[:id])
    session[:current_picture_id] = params[:id]
  end
  
  def new
    @picture = Picture.new
  end
  
  # Create the picture puzzle for the current_user (since users need to have
  # their own copy of the puzzles and progress)
  def create
    @picture = Picture.BuildPicture(current_user, picture_params[:title])
    if (@picture.save)
      redirect_to @picture
    else
      render 'new'
    end
  end
  
  # Sets the character as found if he was properly clicked and
  # identified in the picture.
  def tagCharacter    
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
  
  # Determine the characters that still need to be found in the picture
  def charactersToFind
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
  
end
