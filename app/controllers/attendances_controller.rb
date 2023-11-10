class AttendancesController < ApplicationController
  before_action :authenticate_user!
  def new
    @attendance = Attendance.new
  end

  def create
    @event = Event.find(params[:event_id])
    @attendance = @event.attendances.new(user_id: current_user.id, stripe_customer_id: params[:stripe_customer_id])

    if @attendance.save
      update_event_attendance_count
      redirect_to @event, notice: "Vous participez maintenant à l'événement!"
    else
      redirect_to @event, alert: "Erreur lors de la participation à l'événement."
    end
  end

  private


end