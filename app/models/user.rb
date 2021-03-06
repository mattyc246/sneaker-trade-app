class User < ApplicationRecord

	has_secure_password
	mount_uploader :photo, PhotoUploader
	validates :first_name, presence: true, on: :create
	validates :last_name, presence: true, on: :create
	validates :email, presence: true, on: :create
	validates :email, uniqueness: true, format: {with:  /(\w+)@(\w+).(\w{2,})/, message: "Invalid Email Address"}
	validates :password, presence: true, on: :create
	validates :password, length: {in: 8..20}, on: :create
	validates :address, presence: true, on: :create
	validates :city, presence: true, on: :create
	validates :state, presence: true, on: :create
	validates :postcode, presence: true, on: :create
	validates :country, presence: true, on: :create
	validates :phone_number, presence: true, on: :create
	validates :user_level, presence: true, on: :create

	has_many :postings, dependent: :destroy
	has_many :trades, dependent: :destroy
	has_many :authentications, dependent: :destroy

	before_validation :set_user_level

	def self.authenticate(check_password)

		if check_password == self.password

			return true

		end

	end

	def self.country_list
		{
			'Country' => [
			  "Afghanistan","Aland Islands","Albania","Algeria","American Samoa","Andorra","Angola","Anguilla",
			  "Antarctica","Antigua And Barbuda","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan",
			  "Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan",
			  "Bolivia","Bosnia and Herzegowina","Botswana","Bouvet Island","Brazil","British Indian Ocean Territory",
			  "Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde",
			  "Cayman Islands","Central African Republic","Chad","Chile","China","Christmas Island","Cocos (Keeling) Islands",
			  "Colombia","Comoros","Congo","Congo, the Democratic Republic of the","Cook Islands","Costa Rica",
			  "Cote d'Ivoire","Croatia","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic",
			  "Ecuador","Egypt","El Salvador","Equatorial Guinea","Eritrea","Estonia","Ethiopia","Falkland Islands (Malvinas)",
			  "Faroe Islands","Fiji","Finland","France","French Guiana","French Polynesia","French Southern Territories",
			  "Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe",
			  "Guam","Guatemala","Guernsey","Guinea","Guinea-Bissau","Guyana","Haiti","Heard and McDonald Islands",
			  "Holy See (Vatican City State)","Honduras","Hong Kong","Hungary","Iceland","India","Indonesia","Iran, Islamic Republic of",
			  "Iraq","Ireland","Isle of Man","Israel","Italy","Jamaica","Japan","Jersey","Jordan","Kazakhstan",
			  "Kenya","Kiribati","Korea, Democratic People's Republic of","Korea, Republic of","Kuwait","Kyrgyzstan",
			  "Lao People's Democratic Republic","Latvia","Lebanon","Lesotho","Liberia","Libyan Arab Jamahiriya",
			  "Liechtenstein","Lithuania","Luxembourg","Macao","Macedonia, The Former Yugoslav Republic Of",
			  "Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Marshall Islands","Martinique","Mauritania",
			  "Mauritius","Mayotte","Mexico","Micronesia, Federated States of","Moldova, Republic of","Monaco",
			  "Mongolia","Montenegro","Montserrat","Morocco","Mozambique","Myanmar","Namibia","Nauru","Nepal",
			  "Netherlands","Netherlands Antilles","New Caledonia","New Zealand","Nicaragua","Niger","Nigeria","Niue",
			  "Norfolk Island","Northern Mariana Islands","Norway","Oman","Pakistan","Palau","Palestinian Territory, Occupied",
			  "Panama","Papua New Guinea","Paraguay","Peru","Philippines","Pitcairn","Poland","Portugal","Puerto Rico",
			  "Qatar","Reunion","Romania","Russian Federation","Rwanda","Saint Barthelemy","Saint Helena",
			  "Saint Kitts and Nevis","Saint Lucia","Saint Pierre and Miquelon","Saint Vincent and the Grenadines",
			  "Samoa","San Marino","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles",
			  "Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","Somalia","South Africa","South Georgia and the South Sandwich Islands",
			  "Spain","Sri Lanka","Sudan","Suriname","Svalbard and Jan Mayen","Swaziland","Sweden","Switzerland",
			  "Syrian Arab Republic","Taiwan, Province of China","Tajikistan","Tanzania, United Republic of",
			  "Thailand","Timor-Leste","Togo","Tokelau","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan",
			  "Turks and Caicos Islands","Tuvalu","Uganda","Ukraine","United Arab Emirates","United Kingdom","United States",
			  "United States Minor Outlying Islands","Uruguay","Uzbekistan","Vanuatu","Venezuela","Viet Nam","Virgin Islands, British",
			  "Virgin Islands, U.S.","Wallis and Futuna","Western Sahara","Yemen","Zambia","Zimbabwe"]

		}

	end

	def self.superadmin?

		current_user.user_level == 'superadmin'

	end

	def self.create_with_auth_and_hash(authentication, auth_hash)

	   user = self.new(
	     first_name: auth_hash["info"]["first_name"],
	     last_name: auth_hash["info"]["last_name"],
	     email: auth_hash["info"]["email"],
	     password: SecureRandom.hex(10)
	   )
	   user.save(:validate => false)
	   user.authentications << authentication
	   return user
	 end

	 # grab google to access google for user data
	 def google_token
	   x = self.authentications.find_by(provider: 'google_oauth2')
	   return x.token unless x.nil?
	 end


	private

	def set_user_level

		self.user_level = "basic"

	end

end
