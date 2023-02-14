require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"
require "examples/job_examples"

RSpec.describe "Jobs", type: :request do
  include_context "sign in user"

  before :all do
    @job = create :job, user: @user
  end

  describe "GET /index" do
    before(:all) { get jobs_path, headers: @auth_headers }
    include_examples "response status", 200

    it "returns an array" do
      expect(json_body["data"]).to be_an_instance_of(Array)
    end

    context "each element of the array" do
      it_behaves_like("a job") { let(:job) { json_body["data"][0] } }
    end
  end

  describe "GET /show" do
    before(:all) { get job_path(@job), headers: @auth_headers }
    include_examples "response status", 200
    context "response body" do
      it_behaves_like("a job") { let(:job) { json_body["data"] } }
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before(:all) do
        post jobs_path, params: {job: build(:job).attributes}, headers: @auth_headers
      end
      include_examples "response status", 200

      context "response body" do
        it_behaves_like("a job") { let(:job) { json_body["data"] } }
      end

      it "creates a new job" do
        expect {
          post jobs_path, params: {job: build(:job).attributes}, headers: @auth_headers
        }.to change { Job.count }.by(1)
      end
    end

    context "with invalid params" do
      before(:all) do
        post jobs_path, params: {job: {title: nil}}, headers: @auth_headers
      end
      include_examples "response status", 422

      it_behaves_like "error response"

      it "does not create a new job" do
        expect {
          post jobs_path, params: {job: {title: nil}}, headers: @auth_headers
        }.not_to change { Job.count }
      end
    end
  end

  describe "PUT/PATCH /update" do
    before(:all) do
      @new_job = build(:job)
      @valid_params = {job: @new_job.attributes}
      @invalid_params = {job: {title: nil}}
    end

    context "with valid params and when the job exists" do
      before(:all) do
        put job_path(@job), params: @valid_params, headers: @auth_headers
      end

      include_examples "response status", 200

      context "response body" do
        it_behaves_like("a job") { let(:job) { json_body["data"] } }
      end

      it "updates the job" do
        updated_job = Job.find(@job.id)
        expect(updated_job.title).to eq @new_job.title
        expect(updated_job.start_date).to eq @new_job.start_date
        expect(updated_job.city).to eq @new_job.city
      end
    end

    context "with invalid params" do
      before(:all) do
        put job_path(@job), params: @invalid_params, headers: @auth_headers
      end
      include_examples "response status", 422
      it_behaves_like "error response"

      it "does not update the job" do
        updated_job = Job.find(@job.id)
        expect(updated_job).to eq @job
      end
    end

    context "when job does not exist" do
      before(:all) do
        put job_path(build_stubbed(:job)), params: @valid_params, headers: @auth_headers
      end
      include_examples "response status", 404
      it_behaves_like "error response"
    end
  end

  describe "DELETE /destroy" do
    context "when the job exists" do
      before :all do
        delete job_path(create(:job)), headers: @auth_headers
      end
      include_examples "response status", 200
      it_behaves_like("a job") { let(:job) { json_body["data"] } }
    end

    context "when the job does not exist" do
      before :all do
        delete job_path(build_stubbed(:job)), headers: @auth_headers
      end
      include_examples "response status", 404
      it_behaves_like "error response"
    end
  end
end
