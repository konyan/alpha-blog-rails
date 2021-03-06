require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Nyan", email: "n@gmail.com", password: "123456", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user)
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: {category: { name: "sports"}}
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end

  test 'invalid category submission results in failure' do
    sign_in_as(@user)
    get new_category_path
    assert_template 'categories/new'
    assert_select "h1", text: "Category New Category"
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: { name: ""}}
    end
    assert_template 'categories/new'
    assert_select 'h2.card-title'
    assert_select "h2", text: "2 errors"
    assert_select 'div.card-body'
  end
end