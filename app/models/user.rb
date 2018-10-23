class User < ApplicationRecord

	has_secure_password
	mount_uploader :photo, AvatarUploader

end
