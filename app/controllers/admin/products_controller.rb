class Admin::ProductsController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_required

    layout 'admin'

    def index
        @products = Product.order('position ASC').paginate(page: params[:page], per_page: 5)
     end

    def show
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
        @photo = @product.photos.build
      end

    def create
        @product = Product.new(product_params)
        if @product.save
            unless params[:photos].nil?
                params[:photos]['image'].each do |a|
                    @photo = @product.photos.create(image: a)
                end
            end
            redirect_to admin_products_path
        else
            render :new
        end
    end

    def edit
        @product = Product.find(params[:id])
end

    def update
        @product = Product.find(params[:id])

        if !params[:photos].nil?
            @product.photos.destroy_all
            params[:photos]['image'].each do |a|
                @picture = @product.photos.create(image: a)
            end
            @product.update(product_params)
            redirect_to admin_products_path

        elsif @product.update(product_params)
            redirect_to admin_products_path
        else
            render :edit
      end
    end

    def destroy
        @product = Product.find(params[:id])

        @product.destroy
        redirect_to admin_products_path, alert: 'product deleted'
    end

    def publish
        @product = Product.find(params[:id])
        @product.publish!
        redirect_to :back
    end

    def hide
        @product = Product.find(params[:id])
        @product.hide!
        redirect_to :back
    end

    def move_up
        @product = Product.find(params[:id])
        @product.move_higher
        redirect_to :back
   end

    def move_down
        @product = Product.find(params[:id])
        @product.move_lower
        redirect_to :back
    end

    private

    def product_params
        params.require(:product).permit(:title, :slogan, :description, :quantity, :price, :image, :attachment, :category, :is_hidden)
    end
end
