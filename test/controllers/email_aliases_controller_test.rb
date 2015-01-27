require 'test_helper'

class EmailAliasesControllerTest < ActionController::TestCase
  setup do
    @email_alias = email_aliases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:email_aliases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create email_alias" do
    assert_difference('EmailAlias.count') do
      post :create, email_alias: { destination: @email_alias.destination, domain_id: @email_alias.domain_id, source: @email_alias.source }
    end

    assert_redirected_to email_alias_path(assigns(:email_alias))
  end

  test "should show email_alias" do
    get :show, id: @email_alias
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @email_alias
    assert_response :success
  end

  test "should update email_alias" do
    patch :update, id: @email_alias, email_alias: { destination: @email_alias.destination, domain_id: @email_alias.domain_id, source: @email_alias.source }
    assert_redirected_to email_alias_path(assigns(:email_alias))
  end

  test "should destroy email_alias" do
    assert_difference('EmailAlias.count', -1) do
      delete :destroy, id: @email_alias
    end

    assert_redirected_to email_aliases_path
  end
end
