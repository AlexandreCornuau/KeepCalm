require "json"

class InterventionsController < ApplicationController
    before_action :set_intervention, only: [:show, :update, :recap, :recap_pdf]
    before_action :set_chat_case, only: [:recap, :recap_pdf]

  def index
    # Affiche seulement les interventions dans la page index intervention, lorsque le chat est fini, et le case id créer
    @interventions = Intervention.where.not(case_id: nil)
    # @interventions = Intervention.all (ancien code)
  end

  def show
    getCity()
    getDaes()
    @case = Case.find(params[:case_id])
    @intervention.address = params[:address]
    unless @intervention.start_time.present?
      now = Time.current
      @intervention.start_time ||= Time.zone.local(now.year, now.month, now.day, now.hour, now.min, now.sec)
    end
    @intervention.save
  end

  def update
    @intervention.update(intervention_params)
  end

  def recap
    now = Time.current
    @intervention.end_time ||= Time.zone.local(now.year, now.month, now.day, now.hour, now.min, now.sec)
    @intervention.save
  end

  def recap_pdf

    template = File.read(Rails.root.join("app/views/interventions/recap_pdf.html.erb"))
    layout = File.read(Rails.root.join("app/views/layouts/pdf.html.erb"))

    # Encoder le logo en base64
    logo_path = Rails.root.join("app/assets/images/logo.png")
    @logo_base64 = Base64.strict_encode64(File.read(logo_path))

    # Interpréter le template
    content = ERB.new(template).result(binding)

    # Injecter le contenu dans le layout
    layout_with_content = layout.gsub("<%= yield %>", content)

    # Interpréter le layout (pour le titre et autres ERB)
    full_html = ERB.new(layout_with_content).result(binding)

    pdf = Grover.new(full_html, format: 'A4', print_background: true).to_pdf

    send_data pdf,
              filename: "recap_intervention_#{@intervention.id}.pdf",
              type: "application/pdf",
              disposition: "inline"
  end

private

  def set_intervention
    @intervention = Intervention.find(params[:id])
  end

  def set_chat_case
    @chat = @intervention.chat
    @case = @intervention.case
  end

  def intervention_params
    params.require(:intervention).permit(:address, :title, :age, :start_time, :end_time)
  end
end
