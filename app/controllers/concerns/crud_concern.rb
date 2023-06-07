module CrudConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_object, only: %i[edit update destroy show undelete]
  end

  def index
    authorize base_class

    init_pagination

    @objects = objects_paginated
  end

  def show
    return redirect_to_list unless @object

    authorize @object
  end

  def new
    authorize object_class

    @object = object_class.new(initial_value)
  end

  def create
    authorize object_class

    @object = object_class.new(form_values)

    if @object.valid?
      @object.save!

      redirect_to_show(@object)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @object

    render "new"
  end

  def update
    authorize @object

    @object.assign_attributes(form_values)

    if @object.valid?
      @object.save!

      redirect_to_show(@object)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @object

    @object.destroy

    redirect_to_list
  end

  private

  def redirect_to_list
    redirect_to polymorphic_path(base_class)
  end

  def redirect_to_show(object)
    redirect_to polymorphic_path(object, locale: @page_lang)
  end

  def initial_value
    {}
  end

  def total_objects
    objects_query.count.to_f
  end

  def init_pagination
    @per_page     = per_page
    @page         = params[:page].present? ? params[:page].to_i : 1
    @total_pages  = (total_objects / @per_page.to_f).ceil
    @data         = url_params.select { |_, value| !value.nil? && !value.empty? }

    set_page_url
  end

  def set_page_url
    @page_url = "#{@page_url}?#{@data.to_query}"
  end

  def model_params
  end

  def url_allowed_params
    [:page, :q]
  end

  def url_params
    params.permit(url_allowed_params).to_hash
  end

  def form_values
    params.require(model_params).permit(strong_params).to_hash
  end

  def per_page
    20
  end

  def objects_query
    object_class.all.order(base_class.default_sort)
  end

  def objects_paginated
    objects = objects_query

    objects.page(@page).per(@per_page)
  end

  def base_class
    raise NotImplementedError
  end

  def object_class
    raise NotImplementedError
  end

  def use_slug?
    true
  end

  def set_object
    return @object = object_class.find_by(slug: params[:slug]) if use_slug?

    @object = object_class.find params[:id]

  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
