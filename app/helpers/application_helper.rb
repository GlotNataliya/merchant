module ApplicationHelper
  def form_error_notification(object)
    if object.errors.any?
      tag.div class: "text-danger rounded-pill bg-light p-3 text-center" do
        object.errors.full_messages.to_sentence.capitalize
      end
    end
  end
end
