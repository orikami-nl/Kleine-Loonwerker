class Picture < ActiveRecord::Base
	attr_accessible :photo, :category, :position
	validates_presence_of :photo, :category
	before_save :set_position, :only => [:create]
  mount_uploader :photo, PictureUploader

	def set_position
		last_picture = Picture.where(:category => self.category).order("position").last
		if last_picture.nil?
			self.position = 1
		else
			self.position = last_picture.position + 1
		end
	end

	protected

	def move_up
		first_position = Picture.where(:category => self.category).order("position").first.position
		if self.position > first_position
			mem = self.position
			previous_picture = self.previous_picture
			self.update_attribute(:position, previous_picture.position)
			previous_picture.update_attribute(:position, mem)
		end
	end

	def move_down
		last_position = Picture.where(:category => self.category).order("position").last.position
		if self.position < last_position
			mem = self.position
			next_picture = self.next_picture
			self.update_attribute(:position, next_picture.position)
			next_picture.update_attribute(:position, mem)
		end
	end

	def previous_picture
	  Picture.order("position").last(:conditions => ["position < ? and category = ?", self.position, self.category])
	end

	def next_picture
	  Picture.order("position").first(:conditions => ["position > ? and category = ?", self.position, self.category])
	end
end
