require 'test_helper'

class ExcelJsonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get excel_jsons_index_url
    assert_response :success
  end

  test "should get show" do
    get excel_jsons_show_url
    assert_response :success
  end

  test "should get create" do
    get excel_jsons_create_url
    assert_response :success
  end

end
