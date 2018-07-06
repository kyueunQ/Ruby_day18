class Movie < ApplicationRecord
    # 해당 컬럼은 ImageUploader에서 관리할 것임
    mount_uploader :image_path, ImageUploader
    has_many :likes
    has_many :comments
    
    paginates_per 8
    
end
