class Picture < ActiveRecord::Base
	attr_accessible :photo, :category, :position
	validates_presence_of :photo, :category
	before_save :set_position, :only => [:create]
  mount_uploader :photo, PictureUploader

	def set_position
		last_picture = Picture.where(:category => self.category).order("position").last
		if last_picture.nil?
			self.position = 0
		else
			self.position = last_picture.position + 1
		end
	end

	protected

	def move_up
		if self.position > 1
			mem = self.position
			self.position = self.previous_picture.position
			self.previous_picture.position = mem
		end
	end

	def move_down
		last_position = Picture.where(:category => self.category).last.position
		if self.position < last_position
			mem = self.position
			self.position = self.next_picture.position
			self.next_picture.position = mem
		end
	end

	def previous_picture
	  self.class.last(:conditions => ["podition < ? and category = ?", self.position, self.category])
	end

	def next_picture
	  self.class.first(:conditions => ["position > ? and category = ?", self.position, self.category])
	end
end
