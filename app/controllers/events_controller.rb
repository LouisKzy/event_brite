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
    @event.admin = current_user
    if @event.save
      redirect_to @event, notice: "L'événement a été créé avec succès."
    else
      render 'new'
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "L'événement a été mis à jour avec succès!"
    else
      render 'edit'
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: "L'événement a été supprimé avec succès!"
  end

  private

  def can_edit
    if current_user == @event.admin_id
      
    end
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_date, :duration, :price, :location, :admin_id)
  end
end