# -*- coding: UTF-8 -*-

class ApplicationController < ActionController::Base
  protect_from_forgery
  include UseCases

end
