# -*- coding: UTF-8 -*-

class GurusController < ApplicationController

  def new
    @rm = NewGuru.new.exec
  end

  def index
    @rm = ListGurus.new.exec
  end

  def create
    @rm = CreateGuru.new( :atts => params[:guru] ).exec
    @rm.ok? ? redirect_to( gurus_path ) : render( :new )
  end

  def edit
    @rm = EditGuru.new.exec
  end

end
