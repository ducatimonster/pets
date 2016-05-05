class ReportsController < ApplicationController

  # def return_visit
  #   @pet_id = params[:pet_id]
  #   @groomings = Grooming.pet_groomings(@pet_id)
  # end

  def incidents

    if params[:begindate].present? && params[:enddate].present?
      @begindate = params[:begindate]
      @enddate = params[:enddate]
      selection = params[:order].to_s

      @beginF = @begindate.to_date.strftime("%m/%d/%Y") rescue ""
      @endF  = @enddate.to_date.strftime("%m/%d/%Y") rescue ""

      if selection == 'Ascending'
        @order = 'asc'
      else
        @order = 'desc'
      end

      @incidents = Incident.pet_incidents(@begindate, @enddate, @order).page(params[:page]).per_page(15)
    else
      @incidents = Incident.all.where(incident_date: Date.today).order(created_at: :desc)
    end

  end

  def new_clients
  #   @begindate = params[:begindate]
  #   @enddate = params[:enddate]
  #   selection = params[:order].to_s
  #
  #   @beginF = @begindate.to_date.strftime("%m/%d/%Y") rescue ""
  #   @endF  = @enddate.to_date.strftime("%m/%d/%Y") rescue ""
  #
  #   if selection == 'Ascending'
  #     @order = 'asc'
  #   else
  #     @order = 'desc'
  #   end
  #   @clients = Client.new_accounts(@begindate, @enddate, @order).page(params[:page]).per_page(15)
  # else
  #   @incidents = Incident.all.where(incident_date: Date.today).order(created_at: :desc)


    if params[:begindate].present? && params[:enddate].present?
      @begindate = params[:begindate]
      @enddate = params[:enddate]
      selection = params[:order].to_s

      @beginF = @begindate.to_date.strftime("%m/%d/%Y") rescue ""
      @endF  = @enddate.to_date.strftime("%m/%d/%Y") rescue ""

      if selection == 'Ascending'
        @order = 'asc'
      else
        @order = 'desc'
      end

      @clients = Client.new_accounts(@begindate, @enddate, @order).page(params[:page]).per_page(15)
    else
      @clients = Client.all.where("created_at >= ?", Time.zone.now.beginning_of_day).order(created_at: :desc).page(params[:page]).per_page(15)
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Client was successfully deleted.' }
      format.json { head :no_content }
    end
  end


  def return_visit
    @days = params[:days]
    @num_days= @days.to_s
    selection = params[:order].to_s

    if selection == 'Ascending'
      @order = 'asc'
    else
      @order = 'desc'
    end

    @visits = Grooming.last_visit(@num_days, @order).page(params[:page]).per_page(15)
  end

  def expired_rabies

    if params[:begindate].present? && params[:enddate].present?
      @begindate = params[:begindate]
      @enddate = params[:enddate]
      selection = params[:order].to_s

      @beginF = @begindate.to_date.strftime("%m/%d/%Y") rescue ""
      @endF  = @enddate.to_date.strftime("%m/%d/%Y") rescue ""

      if selection == 'Ascending'
        @order = 'asc'
      else
        @order = 'desc'
      end

      @shot_records = ShotRecord.rabies_expiration(@begindate, @enddate, @order).page(params[:page]).per_page(15)
    else
      @shot_records = ShotRecord.all.where(shot_expiration: Date.today).order(shot_expiration: :desc).page(params[:page]).per_page(15)
    end


  #   @begindate = params[:begindate]
  #   @enddate = params[:enddate]
  #   selection = params[:order].to_s
  #
  #   @beginF = @begindate.to_date.strftime("%m/%d/%Y") rescue ""
  #   @endF  = @enddate.to_date.strftime("%m/%d/%Y") rescue ""
  #
  #   if selection == 'Ascending'
  #     @order = 'asc'
  #   else
  #     @order = 'desc'
  #   end
  #
  #   @shot_records = ShotRecord.rabies_expiration(@begindate, @enddate, @order).page(params[:page]).per_page(15)
  # end


  end
end

