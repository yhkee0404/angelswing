class Api::V1::ContentsController < ApplicationController
  include ViewPathSync
  prepend_before_action :authenticate_and_set_user, except: [:index]
  append_before_action :find_content, only: [:update, :destroy]
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
    if @content.update(content_params)
      render :show
    else
      render '/message', locals: {message: @content.errors.full_messages[0]}, status: :unprocessable_entity
    end
  end

  def destroy
    if @content.destroy
      render '/message', locals: {message: 'Deleted'}
    else
      render '/message', locals: {message: @content.errors.full_messages[0]}, status: :unprocessable_entity
    end
  end

  private

  def content_params
    params.permit(:title, :body)
  end

  # Api::V1::ApiGuard::AuthenticationController#find_resource
  def find_content
    @content = current_user.contents.find_by(id: params[:id]) if params[:id].present?
    render '/message', locals: {message: 'Forbidden'}, status: :forbidden unless @content
  end
end
