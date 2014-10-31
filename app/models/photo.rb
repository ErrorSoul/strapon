class Photo < ActiveRecord::Base
  mount_uploader :asset, AssetUploader		  
end
