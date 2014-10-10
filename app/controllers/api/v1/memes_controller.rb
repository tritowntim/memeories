module Api
  module V1
    class MemesController < ApplicationController
      before_action :set_meme, only: [:show, :update, :destroy]

      def show
        render_json @meme
      end

      def index
        memes = Meme.all
        render_json memes
      end

      def create
        meme = Meme.create meme_params
        render_json meme
      end

      def update
        @meme.update meme_params
        render_json @meme
      end

      def destroy
        @meme.destroy
        render_json @meme
      end

      private

      def meme_params
        params.require(:meme).permit(:name, :started_at, :emoji, :medium, :description)
      end

      def set_meme
        @meme = Meme.find params[:id]
      end

      def render_json(data)
        render json: data
      end

    end
  end
end
