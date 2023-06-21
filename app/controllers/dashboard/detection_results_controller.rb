# frozen_string_literal: true

module Dashboard
  class DetectionResultsController < DashboardController
    before_action :authorize_doctor!

    def index
      @detection_results = if params[:search].present?
                             DetectionRecord.text_search(params[:search])
                           else
                             DetectionRecord.all.order_by(created_at: :desc)
                           end

      render partial: 'dashboard/partials/detection_results/lists', locals: { results: @detection_results } if turbo_frame_request?
    end

    def show
      @patient = DetectionRecord.find(params[:id]).patient
      # @patient = Patient.find(@detection_result.patient_id)
      # @fundus_image = @patient.fundus_image
      # @fundus_image_url = @fundus_image.service_url if @fundus_image.attached?

      # respond_to do |format|
      #   format.html
      #   format.pdf do
      #     render pdf: 'report',
      #            template: 'dashboard/detection_results/show.pdf.erb',
      #            layout: 'pdf.html.erb',
      #            page_size: 'A4',
      #            encoding: 'UTF-8',
      #            margin: { top: 10, bottom: 10, left: 10, right: 10 },
      #            show_as_html: params.key?('debug')
      #   end
      # end
    end
  end
end
