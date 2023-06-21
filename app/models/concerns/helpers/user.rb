# frozen_string_literal: true

module Helpers
  module User
    extend ActiveSupport::Concern

    included do
      attr_writer :login

      def self.find_first_by_auth_conditions(warden_conditions)
        conditions = warden_conditions.dup
        if (login = conditions.delete(:login))
          any_of({ username: /^#{Regexp.escape(login)}$/i }, { email: /^#{Regexp.escape(login)}$/i }).first
        else
          super
        end
      end

      def self.paginate(page: 1, limit: 10)
        order(created_at: :desc).page(page).per(limit)
      end

      def admin?
        role == 'Admin'
      end

      def doctor?
        role == 'Doctor'
      end

      def login
        @login || username || email
      end

      def active?
        !discarded?
      end

      def inactive?
        discarded?
      end

      def active_for_authentication?
        super && !discarded_at
      end
    end
  end
end
