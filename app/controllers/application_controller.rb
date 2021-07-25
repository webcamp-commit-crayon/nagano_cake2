class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource)
		case resource
			when Admin
				admin_path
			when Customer
				root_path
		end
	end

	private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:last_name, :first_name, :postal_code, :address,
    												                           :phone_number, :last_name_kana, :first_name_kana ])

    end
end
