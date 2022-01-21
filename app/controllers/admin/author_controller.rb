class Admin::AuthorController < Admin::BaseController

	def create
		@author = Author.create!(create_params)
		if (@author.save!)
			redirect_to request.env["HTTP_REFERER"], notice: 'Author was created'
		else
			render json: @author.first_error_message
		end
	end

	protected
	def create_params
		params.require(:author).permit(:name)
	end
end
