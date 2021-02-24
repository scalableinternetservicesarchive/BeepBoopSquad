class TradeController < ApplicationController
  def index
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
