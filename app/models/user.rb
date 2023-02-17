# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :jobs, dependent: :destroy
  has_many :resumes, dependent: :destroy
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills

  has_many :educations, dependent: :destroy
end
