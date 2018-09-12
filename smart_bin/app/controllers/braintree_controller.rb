class BraintreeController < ApplicationController
  respond_to :html, :js

 def payment        
    #only make this page accessable to the current user
    if false
      redirect_to root_url
    else
      @client_token = Braintree::ClientToken.generate        
    end

  end

  def checkout    

   payable_amount = 10

   nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

   result = Braintree::Transaction.sale(
    :amount => payable_amount, 
    :payment_method_nonce => nonce_from_the_client,
    :options => {
     :submit_for_settlement => true
   }
   )

   if result.success?   
    redirect_to root_url
  else
    redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
  end

end
end
