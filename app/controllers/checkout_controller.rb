class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @event_id = params[:event_id] # ou toute autre manière d'obtenir l'ID de l'événement
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total * 100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        event_id: @event_id
      },
      mode: 'payment',
      customer_email: current_user.email,
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url,
    
    )
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @user = current_user
    @event_id = @session.metadata.event_id
    # Crée l'Attendance lors du paiement
    Attendance.create(
      user_id: @user.id,
      stripe_customer_id: @session.id,
      event_id: @event_id
    )

    # Met à jour les informations de l'événement


  end

  def cancel
  end
end