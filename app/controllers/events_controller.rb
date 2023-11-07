class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])

  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_index_path, notice: "L'evenement a été crée !"
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(gossip_params)
      redirect_to gossip_path(@gossip), notice: 'Le potin a été mis à jour avec succès!'
    else
      render 'edit'
    end
  end

  def destroy
  end
end
