# frozen_string_literal: true

module UserHelper
  def user_action_empty_template
    { partial: 'dashboard/components/result_empty',
      locals: { title: 'Nothing happens here',
                description: 'Show user detail by click each data from list, or add one by click <i class="bi bi-person-add"></i> button.',
                lottie_url: ActionController::Base.helpers.asset_path('man-with-task-list') } }
  end

  def user_list_data_template(user, collection: false)
    parameters = (collection ? { collection: user, as: :user } : { locals: { user: } })

    { partial: 'dashboard/partials/users/list_data', **parameters, cache: true }
  end
end
