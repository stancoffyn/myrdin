require 'test_helper'

class CharactersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @params = { api_key: { token: '5a87109edc67d3417f6e' }, character: {}, characters: [] }
    @character = Character.first
  end

  def test_index_with_key
    get '/characters/', params: @params
    assert_response :success
  end

  def test_index_should_not_work_without_key_to_bad_request
    get '/characters/'
    assert_response :bad_request
  end

  def test_index_should_not_work_with_invalid_key
    params_copy = @params
    params_copy[:api_key][:token] = 'noodle'
    get '/characters/', params: params_copy
    assert_response :unauthorized
  end

  def test_update_character_should_work_normally
    params_copy = @params
    params_copy[:character] = { last_online: DateTime.now,
                                name: "#{@character.name}i" }
    put "/characters/#{@character.id}", params: params_copy, as: :json
    assert_response :success, @response.body.to_s
  end

  def test_delete_character_should_work
    new_character = Character.create(name: 'new_character', level: 0,
                                     last_online: DateTime.now,
                                     character_class_type: 1)
    delete "/characters/#{new_character.id}", params: @params
    assert_response :success
  end

  def test_update_character_should_not_work_without_key
    params_copy = @params
    params_copy[:api_key][:token] = 'noodle'
    put "/characters/#{@character.id}", params: params_copy, as: :json
    assert_response :unauthorized
    put "/characters/#{@character.id}", params: {}, as: :json
    assert_response :bad_request
  end

  def test_delete_character_should_not_work_without_key
    params_copy = @params
    params_copy[:api_key][:token] = 'noodle'
    put "/characters/#{@character.id}", params: params_copy, as: :json
    assert_response :unauthorized
    put "/characters/#{@character.id}", params: {}, as: :json
    assert_response :bad_request
  end

  def test_create_and_update_characters_in_a_batch
    c1 = Factory :character
    c2 = Factory :character
    params_copy = @params
    params_copy[:characters] = [c1, c2]
    post '/characters/batch/', params: params_copy, as: :json
    assert_response :success
  end

  def test_create_and_update_characters_in_a_batch_should_not_work_without_right_key
    c1 = Factory :character
    c2 = Factory :character
    params_copy = @params
    params_copy[:characters] = [c1, c2]
    params_copy[:api_key][:token] = nil
    post '/characters/batch/', params: params_copy, as: :json
    assert_response :unauthorized
    params_copy[:api_key][:token] = 'db30b6c9fbb472751247' #view only key
    post '/characters/batch/', params: params_copy, as: :json
    assert_response :unauthorized
    post '/characters/batch/', params: {}, as: :json
    assert_response :bad_request
  end
end
