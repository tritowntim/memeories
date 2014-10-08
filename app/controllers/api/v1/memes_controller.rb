module Api
  module V1
    class MemesController < ApplicationController

      def show
        meme = Meme.find params[:id]
        render_json meme
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
        meme = Meme.find params[:id]
        meme.update meme_params
        render_json meme
      end

      private

      def render_json(data)
        render json: data
      end

      def meme_params
        params.require(:meme).permit(:name, :started_at, :emoji, :medium, :description)
      end

    end
  end
end
