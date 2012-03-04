# -*- coding: UTF-8 -*-

require 'frontends_test_helper'

class GurusControllerTest < GuruWatch::IntegrationTest

  test 'index' do
    get '/gurus'
    assert_response(200)
  end

  test 'new' do
    get '/gurus/new'
    assert_response(200)
  end

  test 'create' do
    post '/gurus', guru: Entities::Guru.valid_attributes
    assert_response(302)
  end

  test 'create invalid' do
    post '/gurus', guru: { name: '' }
    assert_response(200)
    assert_template(:new)
  end

  test 'edit' do
    guru = Entities::Guru.create_valid!
    get "/gurus/#{guru.id}/edit"
    assert_response(200)
  end

  test 'edit with invalid id' do
    get '/gurus/423932442/edit'
    assert_response(404)
  end

  test 'update' do
    guru = Entities::Guru.create_valid!
    put "/gurus/#{guru.id}", guru: { name: 'Updated name' }
    assert_response(302)
  end

  test 'update with invalid attributes' do
    guru = Entities::Guru.create_valid!
    put "/gurus/#{guru.id}", guru: { name: '' }
    assert_response(200)
    assert_template(:edit)
  end

end
