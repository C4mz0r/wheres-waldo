class Picture < ActiveRecord::Base
  has_many :characters
  belongs_to :user
  
  # Build a picture of the specified type in the database for the supplied user
  # Returns the picture object, and caller must call "save" on the returned object
  # user:  The user who will own the picture (typically current_user)
  # pictureTitle:  The title of a picture to create
  def self.BuildPicture(user, pictureTitle)
    case pictureTitle
    when 'Train Station'      
      @pic = user.pictures.build(title: pictureTitle, imageFile: "train-station.jpg")
      @pic.characters.build(name: "Waldo", xPosition: 939, yPosition: 291, isFound: false)
      @pic.characters.build(name: "Wenda", xPosition: 389, yPosition: 582, isFound: false)
      @pic.characters.build(name: "Odlaw", xPosition: 260, yPosition: 587, isFound: false)
      @pic.characters.build(name: "Wizard", xPosition: 452, yPosition: 310, isFound: false)      
      return @pic      
    end
  end
  
end