class StaticPagesController < ApplicationController
  def home
    if params[:q].present?
      @search = Datespot.ransack(params[:q])
      @datespots = @search.result.with_attached_images.preload(:user, :taggings, :comments)
      @datespots = Kaminari.paginate_array(@datespots).page(params[:page]).per(9)
      if params[:tag_name]
        @datespots = @search.result.tagged_with("#{params[:tag_name]}").with_attached_images.preload(:user, :taggings)
        @datespots = Kaminari.paginate_array(@datespots).page(params[:page]).per(9)
      end
    else
      params[:q] = { sorts: 'updated_at desc' }
      @search = Datespot.ransack(params[:q])
      @datespots = @search.result.with_attached_images.preload(:user, :taggings, :comments)
      @datespots = Kaminari.paginate_array(@datespots).page(params[:page]).per(9)
      if params[:tag_name]
        @datespots = @search.result.tagged_with("#{params[:tag_name]}").with_attached_images.preload(:user, :taggings)
        @datespots = Kaminari.paginate_array(@datespots).page(params[:page]).per(9)
      end
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
