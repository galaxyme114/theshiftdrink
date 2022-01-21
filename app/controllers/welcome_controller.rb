class WelcomeController < ApplicationController
  layout 'welcome'

  def index
 		redirect_to (browser.device.mobile?) ? "/m-issue" : "/issue";
  end

	def letsencrypt
		render text: "Gcl13AN0SUH1veBZY_05y2Yv-WUWno3N5fG_2oV7h8A._38qLdbD_IluUi6_kppc5F4RVisuwgMYTKI1xv5L9Lc"
	end

	def loaderio
		render text: "loaderio-89df6155f1caf8969ffbbc4eb70e9951"
	end
end
