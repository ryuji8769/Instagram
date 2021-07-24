class NotificationsController < ApplicationController
	def index
		@notifications.where(checked: false).each do |notification|
		  notification.update_attributes(checked: true)
		end
	end
end
