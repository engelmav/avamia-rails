class Api::V1::CompaniesController < Api::V1::BaseController
  skip_before_action :is_authenticated, only: [:index]

  def index
    @resources = Company.includes(:addresses, :naic).order(params[:order] || 'created_at DESC').paginate(page: params[:page], per_page: params[:per_page] || 30)
  end

  def search
    if (params[:name].present? || params[:code].present?)
      @resources = Company.includes(:addresses, :naic).by_name(params[:name]).by_code(params[:code]).order(params[:order] || 'companies.created_at DESC').paginate(page: params[:page], per_page: params[:per_page] || 30) if (params[:name].present? and params[:code].present?)
      @resources = Company.includes(:addresses, :naic).by_name(params[:name]).order(params[:order] || 'companies.created_at DESC').paginate(page: params[:page], per_page: params[:per_page] || 30) if (params[:name].present? and params[:code].blank?)
      @resources = Company.includes(:addresses, :naic).by_code(params[:code]).order(params[:order] || 'companies.created_at DESC').paginate(page: params[:page], per_page: params[:per_page] || 30) if (params[:name].blank? and params[:code].present?)
    else
      @resources = Company.includes(:addresses, :naic).order(params[:order] || 'created_at DESC').paginate(page: params[:page], per_page: params[:per_page] || 30)
    end
    render :index
  end

end