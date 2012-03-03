# -*- coding: UTF-8 -*-

class ApplicationController < ActionController::Base

  protect_from_forgery

  include UseCases

  rescue_from RubyPersistenceAPI::ObjectNotFound, with: :show_404

  private

    def show_404
      render( file: File.join( Rails.root, 'public', '404' ), status: 404, :format => :html )
    end

end
