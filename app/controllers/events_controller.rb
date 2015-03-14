class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end



  def attend

    @event = Event.find(params[:id])

     if member_signed_in?
       #before_action :authenticate_member!

       @event.attendance = @event.attendance + 1
       @event.save!

       current_member.points = current_member.points + @event.addpoint
       current_member.save!
       redirect_to event_path

     else

       @idnumber = params[:login_params][:idnumber]
       @email = params[:login_params][:email]


       @member = Member.where(:idnumber => @idnumber, :email => @email ).first


       if @member.nil?
         redirect_to event_path
         #show alert that member does not exist
       else
         @event.attendance = @event.attendance + 1
         @event.save!

         @member.points = @member.points + @event.addpoint
         @member.save!
         redirect_to event_path
       end

     end





  end

  def new
    @event = Event.new
  end

  def edit
  end


  def create

    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:eventid, :name, :organized_by, :venue, :schedule, :eventclass, :attendance, :addpoint)
    end
end
