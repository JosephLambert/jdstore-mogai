class Warehouse::ProductsController < ApplicationController
    def index
        @intro5 = Intro.find(5)
        @intro6 = Intro.find(6)
        @intro7 = Intro.find(7)
        @intro8 = Intro.find(8)
        @intro9 = Intro.find(9)
        @productsaw = Product.where(category: 'aw').order('position ASC').published.recent
        @productscw = Product.where(category: 'cw').order('position ASC').published.recent
        @productssw = Product.where(category: 'sw').order('position ASC').published.recent
    end

    def show
        @product = Product.find(params[:id])

        if @product.is_hidden
            flash[:warning] = 'This product already archieved'
            redirect_to root_path
      end
    end
end
