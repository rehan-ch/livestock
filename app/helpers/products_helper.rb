module ProductsHelper
    def image_url(source)
        image_path(URI.join(root_url, url_for(source)))
      end
end
