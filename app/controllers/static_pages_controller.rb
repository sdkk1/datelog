class StaticPagesController < ApplicationController
  def home
    if params[:q].present?
      @search = Datespot.ransack(params[:q])
      @datespots = @search.result.with_attached_images.preload(:user, :taggings, :comments).paginate(page: params[:page], per_page: 9)
      if params[:tag_name]
        @datespots = @search.result.tagged_with("#{params[:tag_name]}").with_attached_images.preload(:user, :taggings).paginate(page: params[:page], per_page: 9)
      end
    else
      params[:q] = { sorts: 'updated_at desc' }
      @search = Datespot.ransack(params[:q])
      @datespots = @search.result.with_attached_images.preload(:user, :taggings, :comments).paginate(page: params[:page], per_page: 9)
      if params[:tag_name]
        @datespots = @search.result.tagged_with("#{params[:tag_name]}").with_attached_images.preload(:user, :taggings).paginate(page: params[:page], per_page: 9)
      end
    end
  end
end
