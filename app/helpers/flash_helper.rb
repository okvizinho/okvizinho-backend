module FlashHelper
  def css_class_for_flash(flash_key)
    case flash_key.to_sym
    when :notice
      "bg-lime-600 text-white"
    when :success
      "bg-lime-600 text-white"
    else
      "bg-red-400 text-white"
    end
  end

  def css_class_for_devise(flash_key)
    case flash_key.to_sym
    when :notice
      "text-primary p-2"
    else
      "text-danger p-2"
    end
  end

  def css_class_for_badge(status)
    case status&.to_sym
    when :approved
      "bg-lime-200 text-lime-700"
    when :refused
      "bg-red-200 text-red-700"
    when :cancelled
      "bg-red-200 text-red-700"
    when :in_progress
      "bg-primary-100 text-primary-500"
    when :requested
      "bg-blue-100 text-blue-500"
    when :pending
      "bg-primary-100 text-primary-500"
    when :waiting_approval
      "bg-orange-100 text-orange-500"
    when :waiting_client_approval
      "bg-orange-100 text-orange-500"
    when :payment_failed
      "bg-red-100 text-red-500"
    when :deadline_reached
      "bg-red-100 text-red-500"
    when :no_creator_started
      "bg-red-100 text-red-500"
    when :no_material_sent
      "bg-red-100 text-red-500"
    when :requested_adjusment
      "bg-blue-100 text-blue-700"
    when :canceled_by_client
      "bg-red-100 text-red-500"
    else
      "bg-gray-100 text-gray-500"
    end
  end
end
