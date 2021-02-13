require "application_system_test_case"

class ExchangesTest < ApplicationSystemTestCase
  setup do
    @exchange = exchanges(:one)
  end

  test "visiting the index" do
    visit exchanges_url
    assert_selector "h1", text: "Exchanges"
  end

  test "creating a Exchange" do
    visit exchanges_url
    click_on "New Exchange"

    fill_in "Amount", with: @exchange.amount
    fill_in "Exchange date", with: @exchange.exchange_date
    fill_in "Type", with: @exchange.type
    fill_in "User", with: @exchange.user_id
    click_on "Create Exchange"

    assert_text "Exchange was successfully created"
    click_on "Back"
  end

  test "updating a Exchange" do
    visit exchanges_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @exchange.amount
    fill_in "Exchange date", with: @exchange.exchange_date
    fill_in "Type", with: @exchange.type
    fill_in "User", with: @exchange.user_id
    click_on "Update Exchange"

    assert_text "Exchange was successfully updated"
    click_on "Back"
  end

  test "destroying a Exchange" do
    visit exchanges_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Exchange was successfully destroyed"
  end
end
