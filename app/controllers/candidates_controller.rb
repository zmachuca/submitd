class CandidatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :show, :index]
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @candidates = Candidate.all
  end

  def show
  end

  def new
    @candidate = current_user.candidates.build
  end

  def edit
  end

  def create
    @candidate = current_user.candidates.build(candidate_params)
    
    if @candidate.save
      redirect_to @candidate, notice: 'Candidate was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: 'Candidate was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
      redirect_to candidates_url, notice: 'Candidate was successfully deleted.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    def correct_user
      @candidate == current_user.candidates.find_by(id: params[:id])
      redirect_to candidates_path, notice: "Not authorized to edit this Candidate" if @candidate.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def candidate_params
      params.require(:candidate).permit(:name, :date_submitted)
    end
end
