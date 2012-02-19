# -*- coding: UTF-8 -*-

class GurusController < ApplicationController

  def index
    @rm = ListGurus.new.exec
  end

  def new
    @rm = NewGuru.new.exec
  end

  def create
    @rm = CreateGuru.new( :atts => params[:guru] ).exec
    @rm.ok? ? redirect_to( gurus_path ) : render( :new )
  end

  def edit
    @rm = EditGuru.new( :id => params[:id].to_i ).exec
  end

end
