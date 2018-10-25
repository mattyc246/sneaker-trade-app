class Posting < ApplicationRecord

	include PgSearch
	mount_uploaders :photos, PhotoUploader
	has_many :trades
	belongs_to :user
	validates :brand, presence: true
	validates :style, presence: true
	validates :color, presence: true
	validates :expected_offer, presence: true
	validates :size, presence: true
	validates :condition, presence: true
	validates :sneaker_type, presence: true
	pg_search_scope :search_title,
                    :against => :title,
                    :using => {:tsearch => {:prefix => true}}

	def self.size_list

		{

			'US Sizes' => ['US1','US2','US3','US4','US4.5','US5','US5.5','US6','US6.5','US7','US7.5',
				'US8','US8.5','US9','US9.5','US10','US10.5','US11','US11.5','US12','US12.5'],
			'UK Sizes' => ['UK1','UK2','UK3','UK4','UK4.5','UK5','UK5.5','UK6','UK6.5','UK7','UK7.5',
				'UK8','UK8.5','UK9','UK9.5','UK10','UK10.5','UK11','UK11.5','UK12','UK12.5'],
			'EUR Sizes' =>['EUR37.5','EUR38','EUR38.5','EUR39','EUR39.5','EUR40','EUR40.5','EUR41','EUR41.5','EUR42','EUR42.5',
				'EUR43','EUR43.5','EUR44','EUR44.5','EUR45','EUR45.5','EUR46','EUR46.5','EUR47','EUR47.5']

		}

	end

	def self.condition
	
		{

			'Condition' => ['1 (Heavily Worn)','2','3','4','5','6','7','8','9','10 (Brand New)']

		}

	end
		
end
