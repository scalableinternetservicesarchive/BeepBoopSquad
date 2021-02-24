class TradeController < ApplicationController
  def index
  end

  def create
    #Parameters: {"authenticity_token"=>"[FILTERED]", "transaction_type"=>"sell", "stock_id"=>"", "selected_stock"=>"1", "num_shares"=>"1", "commit"=>"trade"}
    #parse time! bee do bee do
    input_params = Hash.new
    input_params[:transaction] = Hash.new
    
    trade_selection = params[:transaction_type]
    stock_id = -1
    if trade_selection == "buy"
      stock_id = Stock.find_by_symbol(params[:stock_id])
      if stock_id.nil?
        respond_to do |format|
        format.html { redirect_to new_trade_path, notice: "Unable to find stock symbol" }
        end
        return
      else
        stock_id = stock_id.id
      end
    elsif trade_selection == "sell"
      stock_id = params[:selected_stock]
    end
    input_params[:transaction][:transaction_type] = trade_selection
    input_params[:transaction][:stock_id] = stock_id
    input_params[:transaction][:num_shares] = params[:num_shares]
    input_params[:transaction][:user_id] = session[:user_id]
    input_params[:formats] = :html
    redirect_post(transactions_path, params: input_params)
  end
=begin
<!--
<form>
<div id="owned_stocks">
  <label for="stockname">Owned Stocks:</label>
  <select id="stockname" name="stockname">
    <% if current_user %>
    <% Stock.all.each do |stock| %>
      <option value="#{stock.symbol}"><%=stock.symbol=%></option>
    <% end %>
    <% end %>
  </select>
  <br>
  </div>

<div id="input_stock">
  <label for="stockname">Input Stock Symbol:</label>
  <div class="field">

  </div>
  <br>
</div>

<label for="amount">Amount to trade:</label>
  <select id="amount" name="amount">
    <option value="one">1</option>
  </select>
  <br>
  <div class="actions">
    <%= form.submit "Submit" %>
  </div>
</form>
-->

<div class="trade_selection" id="trade_selection">
    <input type="radio" name="trade_selection" checked value="Buy">                  
       <label id="test">Buy</label>
    <input type="radio" name="trade_selection" value="Sell">                                                
       <label>Sell</label>
</div>

=end
end
