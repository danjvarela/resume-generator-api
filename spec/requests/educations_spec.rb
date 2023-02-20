require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "Educations", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before(:all) do
      create :education, user: @user
      get educations_path, **@auth_headers
    end

    include_examples "response status", 200

    it "should return list of all user educations" do
      expect(json_body).to eq format_to_response(@user.educations)
    end
  end

  describe "GET /show" do
    context "when education is belongs to the user" do
      before(:all) do
        @education = create :education, user: @user
        get education_path(@education), **@auth_headers
      end

      include_examples "response status", 200

      it "should return the education" do
        expect(json_body).to eq format_to_response(@education)
      end
    end

    context "when education does not belong the user" do
      before(:all) { get education_path(create(:education)), **@auth_headers }
      include_examples "error response"
      include_examples "response status", 404
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before :all do
        @original_education_count = Education.count
        post educations_path, params: {education: build(:education, user: @user).attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return the created education" do
        expect(json_body).to eq format_to_response(Education.last)
      end

      it "should create a new education" do
        expect(Education.count).to eq @original_education_count + 1
      end
    end

    context "with invalid params" do
      before :all do
        @original_education_count = Education.count
        post educations_path, params: {education: {title: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      include_examples "error response"

      it "should not create a new education" do
        expect(Education.count).to eq @original_education_count
      end
    end
  end

  describe "PUT/PATCH /update" do
    context "with valid params and when the education exists" do
      before(:all) do
        @education = create :education, user: @user
        @new_education = build(:education, user: @user)
        put education_path(@education), params: {education: @new_education.attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return with the updated education" do
        expect(json_body).to eq format_to_response(Education.find(@education.id))
      end

      it "should update the education" do
        updated_education = Education.find(@education.id)
        expect(updated_education.level).to eq @new_education.level
        expect(updated_education.field_of_study).to eq @new_education.field_of_study
        expect(updated_education.start_date).to eq @new_education.start_date
        expect(updated_education.end_date).to eq @new_education.end_date
      end
    end

    context "with invalid params" do
      before(:all) do
        @education = create :education, user: @user
        put education_path(@education), params: {education: {level: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      include_examples "error response"

      it "does not update the education" do
        updated_education = Education.find(@education.id)
        expect(updated_education.level).to eq @education.level
        expect(updated_education.field_of_study).to eq @education.field_of_study
        expect(updated_education.start_date).to eq @education.start_date
        expect(updated_education.end_date).to eq @education.end_date
      end
    end

    context "when education does not exist" do
      before(:all) do
        put education_path(build_stubbed(:education)), params: {education: build(:education).attributes}, **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end

    context "when the education does not belong to the user" do
      before(:all) { put education_path(create(:education)), params: {education: build(:education).attributes}, **@auth_headers }
      include_examples "response status", 404
      include_examples "error response"
    end
  end

  describe "DELETE /destroy" do
    context "when the education exists" do
      before :all do
        @education = create :education, user: @user
        delete education_path(@education), **@auth_headers
      end

      include_examples "response status", 200

      it "should return the deleted education" do
        expect(json_body).to eq format_to_response(@education)
      end
    end

    context "when the education does not exist" do
      before :all do
        delete education_path(build_stubbed(:education)), **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end

    context "when the education does not belong to the user" do
      before :all do
        delete education_path(create(:education)), **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end
  end
end
