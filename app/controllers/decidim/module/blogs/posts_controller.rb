# frozen_string_literal: true

module Decidim
  module Module
    module Blogs
      # Exposes the blog resource so users can view them
      class PostsController < Decidim::Module::Blogs::ApplicationController
        helper_method :posts, :post, :paginate_posts, :posts_most_commented

        def index; end

        def show; end

        private

        def paginate_posts
          @paginate_posts ||= posts.created_at_desc.page(params[:page]).per(4)
        end

        def post
          @post ||= posts.find(params[:id])
        end

        def posts
          @posts ||= Post.where(feature: current_feature)
        end

        # PROVISIONAL if we implement counter cache
        def posts_most_commented
          @posts_most_commented ||= posts.joins(:comments).group(:id)
                                         .select("count(decidim_comments_comments.id) as counter")
                                         .select("decidim_module_blogs_posts.*").order("counter DESC").created_at_desc.limit(7)
        end
      end
    end
  end
end
