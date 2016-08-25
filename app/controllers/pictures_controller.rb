class PicturesController < ApplicationController
  def show
    @picture = Picture.find(params[:id])
  end
  
  def tagCharacter
    @currentPicture = 1; # need a function to get it.
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
    @currentPicture = 1; # need function...
    @picture = Picture.find(@currentPicture);
    @people = @picture.characters.where(:isFound => false)
    respond_to do |format|
      format.json { render :json => @people.map{ |p| p.name }, :status => 200 }
    end
  end
  
end
