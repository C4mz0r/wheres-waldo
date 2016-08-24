class Character < ActiveRecord::Base
  belongs_to :picture
  
  def wasClicked(x, y)
    #byebug
    differenceX = self.xPosition.to_f - x.to_f; 
    differenceY = self.yPosition.to_f - y.to_f;
    radius = 15; # check if user clicked in this radius around the position
    #byebug 
    if (differenceX * differenceX + differenceY * differenceY <= radius * radius )
      return true;
    end
    return false;
  end
  
end
