# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :jobs
  has_many :resumes
  has_many :user_skills
  has_many :skills, through: :user_skills
end
