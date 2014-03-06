class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post 
  
end




# class Post < ActiveRecord::Base 
#   belongs_to :user
#end