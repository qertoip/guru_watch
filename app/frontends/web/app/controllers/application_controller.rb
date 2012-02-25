# -*- coding: UTF-8 -*-

class ApplicationController < ActionController::Base

  protect_from_forgery

  include UseCases

  rescue_from RubyPersistenceAPI::ObjectNotFound, :with => :show_404

  ## This abstract factory returns a use case implementation depending
  ## on the ...
  #def use_case( name )
  #  klass_name = name.to_s.classify
  #end
  #
  #def set_use_case_impl( use_case_name, use_case_class )
  #
  #end

  private

    def use_case_implementations
      @use_case_implementations ||= {}
    end

    def show_404
      render( :file => File.join( Rails.root, 'public', '404.html' ), :status => 404 )
    end

end
