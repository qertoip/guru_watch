# -*- coding: UTF-8 -*-

require 'frontends_test_helper'

class GurusControllerTest < ActionDispatch::IntegrationTest #ActionDispatch::TestCase

  test 'index' do
    get '/gurus'
    assert_response( 200 )
  end

  test 'new' do
    get '/gurus/new'
    assert_response( 200 )
  end

  test 'create' do
    post '/gurus', { :guru => Entities::Guru.valid_attributes }
    assert_response( 302 )
  end

  test 'create invalid' do
    post '/gurus', { :guru => { :name => '' } }
    assert_response( 200 )
  end

  test 'edit' do
    guru = Entities::Guru.create_valid!
    get "/gurus/#{guru.id}/edit"
    assert_response( 200 )
  end

  test 'edit with invalid id' do
    get '/gurus/423932442/edit'
    assert_response( 404 )
  end

end
