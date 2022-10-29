class Api::V1::ContentsController < ApplicationController
  include ViewPathSync
  before_action :authenticate_and_set_user, except: [:index]
  wrap_parameters false

  def index
    @contents = Content.all
  end

#   def show
#     @content = Content.find(params[:id])
#   end

#   def new
#     @content = Content.new
#   end

  def create
    @content = current_user.contents.new(content_params)

    if @content.save
      render :show, status: :created
    else
      render '/message', locals: {message: @content.errors.full_messages[0]}, status: :unprocessable_entity
    end
  end

#   def edit
#     @content = Content.find(params[:id])
#   end

  def update
    if @content = current_user.contents.find_by(id: params[:id]) and @content.update(content_params)
      render :show
    else
      render '/message', locals: {message: 'Denied'}, status: :forbidden
    end
  end

  def destroy
    if @content = current_user.contents.find_by(id: params[:id]) and @content.destroy
      render '/message', locals: {message: 'Deleted'}
    else
      render '/message', locals: {message: 'Denied'}, status: :forbidden
    end
  end

  private
  def content_params
    params.permit(:title, :body)
  end
end
