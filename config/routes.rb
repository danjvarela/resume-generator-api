Rails.application.routes.draw do
  scope :v1 do
    resources :jobs, except: [:edit, :new]
    mount_devise_token_auth_for "User", at: "auth"
  end
end
