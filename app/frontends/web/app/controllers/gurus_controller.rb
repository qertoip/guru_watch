# -*- coding: UTF-8 -*-

class GurusController < ApplicationController

  def index
    @rm = ListGurus.new.exec
  end

  def new
    @rm = NewGuru.new.exec
  end

  def create
    @rm = CreateGuru.new(atts: params[:guru]).exec
    @rm.ok? ? redirect_to(gurus_path) : render(:new)
  end

  def show
    @rm = ShowGuru.new(id: params[:id]).exec
  end

  def edit
    @rm = EditGuru.new(id: params[:id]).exec
  end

  def update
    @rm = UpdateGuru.new(id: params[:id], atts: params[:guru]).exec
    @rm.ok? ? redirect_to(gurus_path) : render(:edit)
  end

  def destroy
    @rm = DestroyGuru.new(id: params[:id]).exec
    redirect_to(gurus_path)
  end

end
