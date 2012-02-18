# -*- coding: UTF-8 -*-

class ApplicationController < ActionController::Base

  protect_from_forgery

  include UseCases

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

end
