class NoticesController < ApplicationController
  before_action :set_notice, only: [:show, :update, :destroy]

  # GET /notices
  def index
    # @notices = Notice.all

    # render json: @notices

    render json: get_notices
  end

  # GET /notices/1
  def show
    render json: @notice
  end

  # POST /notices
  def create
    @notice = Notice.new(notice_params)

    # if @notice.save
    #   render json: @notice, status: :created, location: @notice
    # else
    #   render json: @notice.errors, status: :unprocessable_entity
    # end
    if @notice.save
      render json: get_notices, status: :created, location: @notice
    else
      render json: @notice.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /notices/1
  def update
    if @notice.update(notice_params)
      # render json: @notice
      render json: get_notices
    else
      render json: @notice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notices/1
  def destroy
    @notice.destroy
    render json: get_notices
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def get_notices
      Notice.order('created_at DESC')
    end

    def set_notice
      @notice = Notice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notice_params
      params.require(:notice).permit(:title, :author, :phone)
    end
end
