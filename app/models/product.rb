class Product < ActiveRecord::Base
	has_many :line_items

	validates :title, :description, :image_url, presence: true, uniqueness: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :image_url, allow_blank: true, format: { 
		with: %r{\.(gif|jpg|png)\Z}i, 
		message: 'Must be a URL for GIF, JPG or PNG image'
	}

	before_destroy :ensure_not_referenced_by_any_cart_item

	private
	def ensure_not_referenced_by_any_cart_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line items are present')
			return false
		end

	end	


end
