require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "Jobs", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before(:all) do
      create :job, user: @user
      get jobs_path, **@auth_headers
    end

    include_examples "response status", 200

    it "should return list of all user jobs" do
      expect(json_body).to eq format_to_response(@user.jobs)
    end
  end

  describe "GET /show" do
    before(:all) do
      @job = create :job, user: @user
      get job_path(@job), **@auth_headers
    end

    include_examples "response status", 200

    it "should return the job" do
      expect(json_body).to eq format_to_response(@job)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before :all do
        @original_job_count = Job.count
        post jobs_path, params: {job: build(:job).attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return the created job" do
        expect(json_body).to eq format_to_response(Job.last)
      end

      it "should create a new job" do
        expect(Job.count).to eq @original_job_count + 1
      end
    end

    context "with invalid params" do
      before :all do
        @original_job_count = Job.count
        post jobs_path, params: {job: {title: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      include_examples "error response"

      it "should not create a new job" do
        expect(Job.count).to eq @original_job_count
      end
    end
  end

  describe "PUT/PATCH /update" do
    context "with valid params and when the job exists" do
      before(:all) do
        @job = create :job, user: @user
        @new_job = build(:job)
        put job_path(@job), params: {job: @new_job.attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return with the updated job" do
        expect(json_body).to eq format_to_response(Job.find(@job.id))
      end

      it "should update the job" do
        updated_job = Job.find(@job.id)
        expect(updated_job.title).to eq @new_job.title
        expect(updated_job.start_date).to eq @new_job.start_date
        expect(updated_job.end_date).to eq @new_job.end_date
      end
    end

    context "with invalid params" do
      before(:all) do
        @job = create :job, user: @user
        put job_path(@job), params: {job: {title: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      include_examples "error response"

      it "does not update the job" do
        updated_job = Job.find(@job.id)
        expect(updated_job.title).to eq @job.title
        expect(updated_job.start_date).to eq @job.start_date
        expect(updated_job.end_date).to eq @job.end_date
      end
    end

    context "when job does not exist" do
      before(:all) do
        put job_path(build_stubbed(:job)), params: {job: build(:job).attributes}, **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end
  end

  describe "DELETE /destroy" do
    context "when the job exists" do
      before :all do
        @job = create :job, user: @user
        delete job_path(@job), **@auth_headers
      end

      include_examples "response status", 200

      it "should return the deleted job" do
        expect(json_body).to eq format_to_response(@job)
      end
    end

    context "when the job does not exist" do
      before :all do
        delete job_path(build_stubbed(:job)), **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end
  end
end
