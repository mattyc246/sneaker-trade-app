class Posting < ApplicationRecord
	mount_uploader :photos, PhotoUploader
end
