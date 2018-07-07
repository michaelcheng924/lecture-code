class CohortsController < ApplicationController
  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(params[:id])
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.new(cohort_params)

    if @cohort.save
      redirect_to @cohort
    else
      flash[:errors] = @cohort.errors.full_messages
      redirect_to new_cohort_path
    end
  end

  def edit
    @cohort = Cohort.find(params[:id])
  end

  def update
    @cohort = Cohort.find(params[:id])

    if @cohort.update(cohort_params)
      redirect_to @cohort
    else
      flash[:errors] = @cohort.errors.full_messages
      redirect_to edit_cohort_path
    end
  end

  def destroy
    Cohort.destroy(params[:id])

    redirect_to cohorts_path
  end

  private

  def cohort_params
    params.require(:cohort).permit(:name)
  end
end
