module Api
  module V1
    class MemesController < ApplicationController

      def index
        @memes = Meme.all
        render json: @memes
      end

    end
  end
end
