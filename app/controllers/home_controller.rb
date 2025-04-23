class HomeController < ApplicationController
  allow_unauthenticated_access
  def index
    Rails.logger.info "Session properties: #{session.to_hash.inspect}"
    Rails.logger.info "Cookie properties : #{cookies.to_hash.inspect}"
  end
end
