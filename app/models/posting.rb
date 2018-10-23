class Posting < ApplicationRecord
	mount_uploader :photos, AvatarUploader
end
