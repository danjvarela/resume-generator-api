Rails.application.routes.draw do
  scope :v1 do
    resources :jobs, except: [:new, :edit]
    resources :companies, only: [:index]
    resources :user_skills, except: [:new, :edit, :update]
    mount_devise_token_auth_for "User", at: "auth"
  end
end
