class FavoritesController < ApplicationController
    
    def create
        @post = Post.find(params[:post_id])
        @favorite = Favorite.new(user: current_user, post: @post)
        
        authorize @favorite
        
        if @favorite.save
            redirect_to [@post.topic, @post]
        else
            flash[:error] = "Unable to add favorite. Please try again."
            redirect_to [@post.topic, @post]
        end
    end
    
    def destroy
        @post = Post.find(params[:post_id])
        @favorite = current_user.favorites.find(params[:id])
        
        authorize @favorite
        
        if @favorite.destroy
            redirect_to [@post.topic, @post]
        else
            flash[:error] = "Unable to remove favorite. Please try again."
            redirect_to [@post.topic, @post]
        end
    end
    
end
