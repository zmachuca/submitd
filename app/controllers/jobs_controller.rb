class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :index]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = current_user.jobs.build
  end

  def edit
  end

  def create
    @job = current_user.jobs.build(job_params)

    if @job.save
      redirect_to @job, notice: 'Job was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
      redirect_to jobs_url, notice: 'Job was successfully deleted.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    def correct_user
      @job == current_user.jobs.find_by(id: params[:id])
      redirect_to jobs_path, notice: "Not authorized to edit this Job" if @job.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:company, :title)
    end
end
